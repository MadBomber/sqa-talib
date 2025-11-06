# Normalized Average True Range (NATR)

The Normalized Average True Range (NATR) is a volatility indicator that expresses the Average True Range (ATR) as a percentage of the closing price, making it easier to compare volatility across different price levels and securities.

## Formula

NATR = (ATR / Close) * 100

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |
| `period` | Integer | No | 14 | Number of periods |

## Returns

Returns an array of NATR values expressed as percentages.

## Usage

```ruby
require 'sqa/tai'

high =  [48.70, 48.72, 48.90, 48.87, 48.82, 49.05, 49.20, 49.35, 49.92, 50.19, 50.12, 50.10, 50.00, 49.75, 49.80]
low =   [47.79, 48.14, 48.39, 48.37, 48.24, 48.64, 48.94, 49.03, 49.50, 49.87, 49.20, 49.00, 48.90, 49.00, 49.10]
close = [48.20, 48.61, 48.75, 48.63, 48.74, 49.03, 49.07, 49.32, 49.91, 50.13, 49.53, 49.50, 49.25, 49.20, 49.45]

natr = SQA::TAI.natr(high, low, close, period: 14)

puts "Current NATR: #{natr.last.round(2)}%"
```

## Interpretation

- **Higher NATR**: Higher volatility relative to price
- **Lower NATR**: Lower volatility relative to price
- **Rising NATR**: Increasing volatility
- **Falling NATR**: Decreasing volatility

## Example: Volatility Comparison

```ruby
# Compare volatility across different stocks
stocks = ['AAPL', 'TSLA', 'SPY']

stocks.each do |ticker|
  high, low, close = load_historical_ohlc(ticker)
  natr = SQA::TAI.natr(high, low, close, period: 14)

  puts "#{ticker} NATR: #{natr.last.round(2)}%"
end
```

## Common Settings

| Period | Use Case |
|--------|----------|
| 14 | Standard (Wilder's original) |
| 7 | More sensitive |
| 21 | Smoother |

## Related Indicators

- [ATR](atr.md) - Average True Range
- [TRANGE](trange.md) - True Range

## See Also

- [Back to Indicators](../index.md)
- [Volatility Indicators Overview](../index.md)
