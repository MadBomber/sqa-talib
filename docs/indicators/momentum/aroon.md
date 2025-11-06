# Aroon (AROON)

Identifies trend changes and strength by measuring time since highest high and lowest low.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high values |
| `low` | Array<Float> | Yes | - | Array of low values |
| `period` | Integer | No | 14 | Period |

## Returns

[aroon_down, aroon_up]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.aroon(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
