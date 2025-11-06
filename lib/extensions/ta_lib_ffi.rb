# frozen_string_literal: true

# Monkey patch for ta_lib_ffi 0.3.0 to fix multi-array parameter bug
#
# This patch fixes a critical bug in ta_lib_ffi 0.3.0 where functions requiring
# multiple array parameters (high, low, close) fail with NoMethodError.
#
# Affected functions:
# - All volatility indicators (ATR, NATR, SAR, TRANGE)
# - All momentum indicators requiring OHLC (CCI, WILLR, ADX, STOCH)
# - All volume indicators (OBV, AD, ADOSC)
# - All candlestick pattern recognition functions (60+ patterns)
#
# This patch can be removed once ta_lib_ffi fixes the upstream bug.

module TALibFFI
  class << self
    # Store original method to call it for non-price parameters
    alias_method :original_setup_input_parameters, :setup_input_parameters

    # Fixed version that properly handles multi-array Price inputs
    #
    # The original code assumes a 1-to-1 mapping between input_arrays and function
    # parameters, but TA_Input_Price parameters can consume multiple arrays.
    #
    # This fix:
    # 1. Tracks position in input_arrays with array_index
    # 2. For each function parameter, checks its type
    # 3. For TA_Input_Price, determines how many arrays are needed from flags
    # 4. Bundles those arrays together: [[high], [low], [close]]
    # 5. Passes the bundle to setup_price_inputs
    # 6. Advances array_index by the number of arrays consumed
    def setup_input_parameters(params_ptr, input_arrays, func_name)
      func_info = function_info_map[func_name]
      array_index = 0  # Track position in input_arrays

      func_info[:inputs].each_with_index do |input_info, param_index|
        case input_info["type"]
        when TA_PARAM_TYPE[:TA_Input_Price]
          # Price inputs consume multiple arrays based on required flags
          required_flags = extract_flags(input_info["flags"], :TA_InputFlags)
          num_arrays = required_flags.length

          # Collect the next num_arrays from input_arrays
          if array_index + num_arrays > input_arrays.length
            raise ArgumentError, "Function #{func_name} requires #{num_arrays} price arrays " \
                               "(#{required_flags.join(', ')}), but only #{input_arrays.length - array_index} " \
                               "provided at position #{array_index}"
          end

          price_arrays = input_arrays[array_index, num_arrays]

          # Pass the bundled arrays to set_input_parameter
          ret_code = set_input_parameter(params_ptr, param_index, price_arrays, input_info)
          check_ta_return_code(ret_code)

          array_index += num_arrays  # Advance by number of arrays consumed

        when TA_PARAM_TYPE[:TA_Input_Real], TA_PARAM_TYPE[:TA_Input_Integer]
          # Single array inputs
          if array_index >= input_arrays.length
            raise ArgumentError, "Not enough input arrays for function #{func_name} " \
                               "(expected array at index #{array_index}, but only #{input_arrays.length} provided)"
          end

          ret_code = set_input_parameter(params_ptr, param_index, input_arrays[array_index], input_info)
          check_ta_return_code(ret_code)

          array_index += 1  # Advance by one

        else
          # Unknown type - should not happen, but handle gracefully
          raise ArgumentError, "Unknown input type #{input_info['type']} for function #{func_name}"
        end
      end

      # Verify all arrays were consumed
      if array_index != input_arrays.length
        raise ArgumentError, "Function #{func_name} expected #{array_index} input arrays " \
                           "but received #{input_arrays.length}"
      end
    end

    # Store original method
    alias_method :original_setup_price_inputs, :setup_price_inputs

    # Fixed version that handles bundled price arrays correctly
    #
    # After the setup_input_parameters fix, price_data is now guaranteed to be
    # an array of arrays: [[high_array], [low_array], [close_array]]
    def setup_price_inputs(params_ptr, index, price_data, flags)
      required_flags = extract_flags(flags, :TA_InputFlags)
      data_pointers = Array.new(6) { Fiddle::Pointer.malloc(0) }

      # price_data is now an array of arrays: [[high], [low], [close]]
      # Each element corresponds to one required flag
      required_flags.each_with_index do |flag, i|
        flag_index = TA_FLAGS[:TA_InputFlags].keys.index(flag)

        # price_data[i] now correctly returns an array (e.g., high, low, or close)
        if price_data[i].nil?
          raise ArgumentError, "Missing price array for flag #{flag} at index #{i}"
        end

        # Validate it's an array
        unless price_data[i].is_a?(Array)
          raise ArgumentError, "Expected array for flag #{flag} at index #{i}, " \
                             "got #{price_data[i].class}"
        end

        data_pointers[flag_index] = prepare_double_array(price_data[i]) if required_flags.include?(flag)
      end

      TA_SetInputParamPricePtr(params_ptr, index, *data_pointers)
    end

    # Store original method
    alias_method :original_calculate_results, :calculate_results

    # Fixed version that correctly determines input_size for Price inputs
    #
    # The original code expects input_arrays[0][0].length for Price inputs,
    # which assumes format [[high], [low], [close]]. Our fix passes [high, low, close],
    # so we need to adjust this check.
    def calculate_results(params_ptr, input_arrays, func_name)
      func_info = function_info_map[func_name]

      # Determine input size based on input type
      input_size = if func_info[:inputs].first["type"] == TA_PARAM_TYPE[:TA_Input_Price]
                     # For Price inputs, input_arrays is [high, low, close]
                     # Get length from the first array
                     input_arrays[0].length
                   else
                     # For other inputs, get length normally
                     input_arrays[0].length
                   end

      out_begin = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)
      out_size = Fiddle::Pointer.malloc(Fiddle::SIZEOF_INT)
      output_arrays = setup_output_buffers(params_ptr, input_size, func_name)

      begin
        ret_code = TA_CallFunc(params_ptr, 0, input_size - 1, out_begin, out_size)
        check_ta_return_code(ret_code)

        actual_size = out_size[0, Fiddle::SIZEOF_INT].unpack1("l")
        format_output_results(output_arrays, actual_size, func_name)
      ensure
        out_begin.free
        out_size.free
      end
    end
  end
end
