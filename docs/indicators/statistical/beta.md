# Beta (BETA)

Measures the volatility or systematic risk compared to another series.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices1` | Array<Float> | Yes | - | Array of prices1 values |
| `prices2` | Array<Float> | Yes | - | Array of prices2 values |
| `period` | Integer | No | 5 | Period |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.beta(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Statistical Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
