# Typical Price (TYPPRICE)

The Typical Price is a price transformation that represents the average of the High, Low, and Close prices, giving equal weight to each value.

## Formula

Typical Price = (High + Low + Close) / 3

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |

## Returns

Returns an array of typical price values.

## Usage

```ruby
require 'sqa/tai'

high =  [48.70, 48.72, 48.90, 48.87, 48.82]
low =   [47.79, 48.14, 48.39, 48.37, 48.24]
close = [48.20, 48.61, 48.75, 48.63, 48.74]

typprice = SQA::TAI.typprice(high, low, close)

puts "Current Typical Price: #{typprice.last.round(2)}"
```

## Interpretation

The typical price is commonly used in:
- Commodity Channel Index (CCI) calculation
- Volume-weighted calculations
- Pivot point calculations

## Related Indicators

- [AVGPRICE](avgprice.md) - Average Price
- [MEDPRICE](medprice.md) - Median Price
- [WCLPRICE](wclprice.md) - Weighted Close Price
- [CCI](../momentum/cci.md) - Uses Typical Price

## See Also

- [Back to Indicators](../index.md)
- [Price Transform Overview](../index.md)
