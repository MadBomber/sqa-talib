# Stochastic RSI (STOCHRSI)

Applies Stochastic formula to RSI values.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `period` | Integer | No | 14 | Period |
| `fastk_period` | Integer | No | 5 | Fastk period |
| `fastd_period` | Integer | No | 3 | Fastd period |

## Returns

[fastk, fastd]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.stochrsi(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
