# Hilbert Transform - Dominant Cycle Period (HT_DCPERIOD)

Identifies the dominant cycle period using Hilbert Transform.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.ht_dcperiod(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Cycle Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
