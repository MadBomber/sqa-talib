# MACD with Controllable MA Type (MACDEXT)

MACD with customizable moving average types.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `fast_period` | Integer | No | 12 | Fast period |
| `fast_ma_type` | Float/Array | No | 0 | Fast ma type |
| `slow_period` | Integer | No | 26 | Slow period |
| `slow_ma_type` | Float/Array | No | 0 | Slow ma type |
| `signal_period` | Integer | No | 9 | Signal period |
| `signal_ma_type` | Float/Array | No | 0 | Signal ma type |

## Returns

[macd, signal, histogram]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.macdext(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
