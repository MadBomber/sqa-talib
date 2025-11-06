# MESA Adaptive Moving Average (MAMA)

Adaptive moving average that adjusts to market conditions.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `fast_limit` | Float/Array | No | 0.5 | Fast limit |
| `slow_limit` | Float/Array | No | 0.05 | Slow limit |

## Returns

[mama, fama]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.mama(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Volatility Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
