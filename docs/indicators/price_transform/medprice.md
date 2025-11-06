# Median Price (MEDPRICE)

The Median Price is a price transformation that calculates the midpoint between the high and low prices for each period.

## Formula

Median Price = (High + Low) / 2

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |

## Returns

Returns an array of median price values.

## Usage

```ruby
require 'sqa/tai'

high = [48.70, 48.72, 48.90, 48.87, 48.82]
low =  [47.79, 48.14, 48.39, 48.37, 48.24]

medprice = SQA::TAI.medprice(high, low)

puts "Current Median Price: #{medprice.last.round(2)}"
```

## Interpretation

The median price represents the middle of the price range and is useful for:
- Identifying pivot points
- Support/resistance levels
- Base for indicator calculations

## Related Indicators

- [AVGPRICE](avgprice.md) - Average Price
- [TYPPRICE](typprice.md) - Typical Price
- [WCLPRICE](wclprice.md) - Weighted Close Price

## See Also

- [Back to Indicators](../index.md)
- [Price Transform Overview](../index.md)
