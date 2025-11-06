# Plus Directional Movement (PLUS_DM)

Calculates upward directional movement.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high values |
| `low` | Array<Float> | Yes | - | Array of low values |
| `period` | Integer | No | 14 | Period |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.plus_dm(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
