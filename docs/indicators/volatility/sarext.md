# Parabolic SAR Extended (SAREXT)

Extended version of Parabolic SAR with more control parameters.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high values |
| `low` | Array<Float> | Yes | - | Array of low values |
| `start_value` | Float/Array | No | 0.0 | Start value |
| `offset_on_reverse` | Float/Array | No | 0.0 | Offset on reverse |
| `acceleration_init` | Float/Array | No | 0.02 | Acceleration init |
| `acceleration_step` | Float/Array | No | 0.02 | Acceleration step |
| `acceleration_max` | Float/Array | No | 0.20 | Acceleration max |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.sarext(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Volatility Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
