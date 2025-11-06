# Percentage Price Oscillator (PPO)

Shows the percentage difference between two moving averages.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `fast_period` | Integer | No | 12 | Fast period |
| `slow_period` | Integer | No | 26 | Slow period |
| `ma_type` | Float/Array | No | 0 | Ma type |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.ppo(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
