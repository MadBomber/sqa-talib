# Double Exponential Moving Average (DEMA)

The Double Exponential Moving Average (DEMA) is a technical indicator that aims to reduce the lag inherent in traditional moving averages. It uses a double calculation of exponential moving averages to provide a smoother, more responsive indicator.

## Formula

DEMA = 2 * EMA(n) - EMA(EMA(n))

Where n is the time period. The DEMA applies the EMA calculation twice and then subtracts the second EMA from twice the first EMA to reduce lag.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of price values |
| `period` | Integer | No | 30 | Number of periods for calculation |

## Returns

Returns an array of DEMA values. The first several values will be `nil` due to the calculation requiring sufficient data points.

## Usage

```ruby
require 'sqa/tai'

prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08, 46.03, 46.41,
          46.22, 45.64, 46.21, 46.25, 46.08, 46.46,
          46.82, 47.00, 47.32, 47.20, 47.57, 47.80,
          48.00, 48.15, 48.30, 48.40, 48.55, 48.70,
          48.85, 49.00]

# Calculate 30-period DEMA (default)
dema = SQA::TAI.dema(prices)

# Calculate 10-period DEMA for more responsiveness
dema_10 = SQA::TAI.dema(prices, period: 10)

puts "Current DEMA: #{dema.last.round(2)}"
```

## Interpretation

The DEMA responds more quickly to price changes than a simple or exponential moving average:

- **Price above DEMA**: Indicates an uptrend
- **Price below DEMA**: Indicates a downtrend
- **DEMA crossovers**: Can signal trend changes
- **Slope of DEMA**: Indicates trend strength

## Example: DEMA Crossover Strategy

```ruby
prices = load_historical_prices('AAPL')

# Use two DEMA periods for crossover signals
dema_short = SQA::TAI.dema(prices, period: 10)
dema_long = SQA::TAI.dema(prices, period: 30)

# Check for crossover
if dema_short[-2] < dema_long[-2] && dema_short[-1] > dema_long[-1]
  puts "DEMA Bullish Crossover - Potential BUY signal"
elsif dema_short[-2] > dema_long[-2] && dema_short[-1] < dema_long[-1]
  puts "DEMA Bearish Crossover - Potential SELL signal"
end
```

## Example: DEMA as Dynamic Support/Resistance

```ruby
prices = load_historical_prices('TSLA')
dema = SQA::TAI.dema(prices, period: 20)

current_price = prices.last
current_dema = dema.last

distance_pct = ((current_price - current_dema) / current_dema * 100).round(2)

if distance_pct > 5
  puts "Price #{distance_pct}% above DEMA - potential overbought"
elsif distance_pct < -5
  puts "Price #{distance_pct}% below DEMA - potential oversold"
else
  puts "Price near DEMA - potential consolidation"
end
```

## Advantages Over Traditional Moving Averages

1. **Reduced Lag**: Responds faster to price changes than SMA or EMA
2. **Smoother**: Less whipsaw than some faster indicators
3. **Trend Following**: Still maintains good trend-following characteristics
4. **Versatile**: Works well across different timeframes

## Common Settings

| Period | Use Case |
|--------|----------|
| 9-12 | Short-term trading |
| 20-30 | Medium-term trends (standard) |
| 50+ | Long-term trend identification |

## Related Indicators

- [EMA](ema.md) - Exponential Moving Average
- [TEMA](tema.md) - Triple Exponential Moving Average
- [SMA](sma.md) - Simple Moving Average
- [T3](t3.md) - Tillson T3 Moving Average

## See Also

- [Back to Indicators](../index.md)
- [Overlap Studies Overview](../index.md)
