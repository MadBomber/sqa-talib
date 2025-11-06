# Harami Cross

Harami Cross is a candlestick pattern that provides potential trading signals based on price action.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `open` | Array<Float> | Yes | - | Array of open prices |
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |

## Returns

Returns an array of pattern signals ranging from -100 to +100:
- 0: No pattern detected
- +100: Bullish pattern
- -100: Bearish pattern

## Usage

```ruby
require 'sqa/tai'

open =  [48.00, 48.20, 48.50, 48.40, 48.30]
high =  [48.70, 48.72, 48.90, 48.87, 48.82]
low =   [47.79, 48.14, 48.39, 48.37, 48.24]
close = [48.20, 48.61, 48.75, 48.63, 48.74]

pattern = SQA::TAI.cdl_haramicross(open, high, low, close)

puts "Pattern detected: #{pattern.last}"
```

## Interpretation

This candlestick pattern should be used in conjunction with other technical indicators and price action analysis. Consult candlestick pattern references for detailed interpretation.

## Related Indicators

- [Doji](cdl_doji.md)
- [Hammer](cdl_hammer.md)
- [Engulfing](cdl_engulfing.md)
- [Back to Patterns](index.md)

## See Also

- [Back to Indicators](../index.md)
- [Pattern Recognition Overview](../index.md)
