# Moving Average with Variable Period (MAVP)

Moving average where period varies for each data point.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `periods` | Array<Float> | Yes | - | Array of periods values |
| `ma_type` | Float/Array | No | 0 | Ma type |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.mavp(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Volatility Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
