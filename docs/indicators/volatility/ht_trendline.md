# Hilbert Transform - Instantaneous Trendline (HT_TRENDLINE)

Uses Hilbert Transform to identify the instantaneous trendline.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |

## Returns

Returns an array of indicator values.

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.ht_trendline(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Volatility Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
