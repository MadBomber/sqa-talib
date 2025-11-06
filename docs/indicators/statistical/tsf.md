# Time Series Forecast (TSF)

Projects the linear regression line one period forward.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |
| `period` | Integer | No | 14 | Period |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.tsf(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Statistical Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
