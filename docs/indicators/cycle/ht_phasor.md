# Hilbert Transform - Phasor Components (HT_PHASOR)

Returns the in-phase and quadrature components.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of prices values |

## Returns

[inphase, quadrature]

## Usage

```ruby
require 'sqa/tai'

# Example usage
result = SQA::TAI.ht_phasor(prices)

puts "Current value: #{result.last.round(2)}"
```

## Interpretation

Please refer to technical analysis resources for interpretation guidelines for this indicator.

## Related Indicators

- [Back to Indicators](../index.md)
- [Cycle Indicators Overview](../index.md)

## See Also

- [Back to Indicators](../index.md)
