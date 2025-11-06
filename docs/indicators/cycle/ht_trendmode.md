# Hilbert Transform - Trend vs Cycle Mode (HT_TRENDMODE)

Determines if market is in trend mode (1) or cycle mode (0).

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
result = SQA::TAI.ht_trendmode(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Cycle Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
