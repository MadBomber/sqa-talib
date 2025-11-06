# Variance (VAR)

Measures the dispersion of price values.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `period` | Integer | No | 5 | Period |
| `nbdev` | Float/Array | No | 1.0 | Nbdev |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.var(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Statistical Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
