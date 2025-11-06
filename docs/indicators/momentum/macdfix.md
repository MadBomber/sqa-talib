# MACD Fix 12/26 (MACDFIX)

MACD with fixed 12/26 periods.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `signal_period` | Integer | No | 9 | Signal period |

## Returns

[macd, signal, histogram]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.macdfix(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
