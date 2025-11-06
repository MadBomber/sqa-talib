# Weighted Close Price (WCLPRICE)

The Weighted Close Price gives more importance to the closing price compared to the high and low, as the close is often considered the most significant price of the period.

## Formula

Weighted Close Price = (High + Low + Close + Close) / 4 = (High + Low + 2 * Close) / 4

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |

## Returns

Returns an array of weighted close price values.

## Usage

```ruby
require 'sqa/tai'

high =  [48.70, 48.72, 48.90, 48.87, 48.82]
low =   [47.79, 48.14, 48.39, 48.37, 48.24]
close = [48.20, 48.61, 48.75, 48.63, 48.74]

wclprice = SQA::TAI.wclprice(high, low, close)

puts "Current Weighted Close: #{wclprice.last.round(2)}"
```

## Interpretation

The weighted close emphasizes the closing price, which is often considered the most important price because:
- It represents the final consensus for the period
- It's the reference point for the next period
- It's used in many trading strategies

## Related Indicators

- [AVGPRICE](avgprice.md) - Average Price
- [MEDPRICE](medprice.md) - Median Price
- [TYPPRICE](typprice.md) - Typical Price

## See Also

- [Back to Indicators](../index.md)
- [Price Transform Overview](../index.md)
