# Balance of Power (BOP)

Measures the strength of buyers versus sellers.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `open` | Array<Float> | Yes | - | Array of open values |
| `high` | Array<Float> | Yes | - | Array of high values |
| `low` | Array<Float> | Yes | - | Array of low values |
| `close` | Array<Float> | Yes | - | Array of close values |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.bop(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
