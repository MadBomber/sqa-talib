# Triple Smooth EMA (TRIX)

1-day Rate-Of-Change of a Triple Smooth EMA.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `period` | Integer | No | 30 | Period |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.trix(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
