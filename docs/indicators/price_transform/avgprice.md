# Average Price (AVGPRICE)

The Average Price is a simple price transformation indicator that calculates the arithmetic mean of the Open, High, Low, and Close prices for each period.

## Formula

Average Price = (Open + High + Low + Close) / 4

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `open` | Array<Float> | Yes | - | Array of open prices |
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |

## Returns

Returns an array of average price values.

## Usage

```ruby
require 'sqa/tai'

open =  [48.00, 48.20, 48.50, 48.40, 48.30]
high =  [48.70, 48.72, 48.90, 48.87, 48.82]
low =   [47.79, 48.14, 48.39, 48.37, 48.24]
close = [48.20, 48.61, 48.75, 48.63, 48.74]

avgprice = SQA::TAI.avgprice(open, high, low, close)

puts "Current Average Price: #{avgprice.last.round(2)}"
```

## Interpretation

The average price provides a smooth representation of price action that considers all four OHLC values equally. It's useful for:

- Creating smoother price series for analysis
- Reducing noise in volatile markets
- Base for further calculations

## Example: Average Price vs Close

```ruby
open, high, low, close = load_historical_ohlc('AAPL')
avgprice = SQA::TAI.avgprice(open, high, low, close)

current_close = close.last
current_avg = avgprice.last

if current_close > current_avg
  puts "Close above average - Strong close"
elsif current_close < current_avg
  puts "Close below average - Weak close"
end
```

## Related Indicators

- [MEDPRICE](medprice.md) - Median Price
- [TYPPRICE](typprice.md) - Typical Price
- [WCLPRICE](wclprice.md) - Weighted Close Price

## See Also

- [Back to Indicators](../index.md)
- [Price Transform Overview](../index.md)
