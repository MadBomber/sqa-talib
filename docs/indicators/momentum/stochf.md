# Stochastic Fast (STOCHF)

Fast version of the Stochastic Oscillator.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high values |
| `low` | Array<Float> | Yes | - | Array of low values |
| `close` | Array<Float> | Yes | - | Array of close values |
| `fastk_period` | Integer | No | 5 | Fastk period |
| `fastd_period` | Integer | No | 3 | Fastd period |

## Returns

[fastk, fastd]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.stochf(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
