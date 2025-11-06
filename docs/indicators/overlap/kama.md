# Kaufman Adaptive Moving Average (KAMA)

The Kaufman Adaptive Moving Average (KAMA) is a sophisticated moving average that automatically adjusts its smoothing constant based on market volatility. In trending markets, it becomes faster, and in choppy markets, it slows down to reduce noise.

## Formula

KAMA adapts its smoothing factor based on the Efficiency Ratio (ER):

1. Calculate Efficiency Ratio: ER = Change / Volatility
2. Calculate Smoothing Constant: SC = (ER * (Fast - Slow) + Slow)²
3. Apply: KAMA = KAMA_prev + SC * (Price - KAMA_prev)

Where Fast and Slow are the fastest and slowest smoothing constants.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of price values |
| `period` | Integer | No | 30 | Number of periods for calculation |

## Returns

Returns an array of KAMA values. The first several values will be `nil` due to the calculation requiring sufficient data points.

## Usage

```ruby
require 'sqa/tai'

prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08, 46.03, 46.41,
          46.22, 45.64, 46.21, 46.25, 46.08, 46.46,
          46.82, 47.00, 47.32, 47.20, 47.57, 47.80,
          48.00, 48.15, 48.30, 48.40, 48.55, 48.70,
          48.85, 49.00, 49.15, 49.30]

# Calculate 30-period KAMA (default)
kama = SQA::TAI.kama(prices)

# Calculate 10-period KAMA for shorter-term adaptation
kama_10 = SQA::TAI.kama(prices, period: 10)

puts "Current KAMA: #{kama.last.round(2)}"
```

## Interpretation

KAMA's adaptive nature makes it unique among moving averages:

- **Trending Markets**: KAMA hugs price closely, providing timely signals
- **Choppy Markets**: KAMA flattens out, avoiding whipsaws
- **Price crosses above KAMA**: Potential buy signal
- **Price crosses below KAMA**: Potential sell signal
- **KAMA slope**: Indicates trend strength

## Example: KAMA Trend Following

```ruby
prices = load_historical_prices('AAPL')
kama = SQA::TAI.kama(prices, period: 20)

current_price = prices.last
current_kama = kama.last
previous_kama = kama[-2]

# Check KAMA direction
kama_rising = current_kama > previous_kama
kama_falling = current_kama < previous_kama

# Check price position
price_above = current_price > current_kama
price_below = current_price < current_kama

if kama_rising && price_above
  puts "STRONG UPTREND - KAMA rising, price above"
elsif kama_falling && price_below
  puts "STRONG DOWNTREND - KAMA falling, price below"
elsif kama_rising && price_below
  puts "Pullback in uptrend - potential buy opportunity"
elsif kama_falling && price_above
  puts "Rally in downtrend - potential sell opportunity"
end
```

## Example: KAMA Crossover System

```ruby
prices = load_historical_prices('SPY')
kama = SQA::TAI.kama(prices, period: 20)

# Check for price crossing KAMA
price_current = prices.last
price_previous = prices[-2]
kama_current = kama.last
kama_previous = kama[-2]

# Bullish crossover
if price_previous <= kama_previous && price_current > kama_current
  puts "BULLISH CROSSOVER - Price crossed above KAMA"
  puts "Entry signal: BUY"
# Bearish crossover
elsif price_previous >= kama_previous && price_current < kama_current
  puts "BEARISH CROSSOVER - Price crossed below KAMA"
  puts "Exit/Short signal: SELL"
end
```

## Example: KAMA with Efficiency Ratio

```ruby
prices = load_historical_prices('TSLA')
kama = SQA::TAI.kama(prices, period: 20)

# Calculate simple efficiency proxy (price range vs total movement)
period = 20
price_change = (prices.last - prices[-period]).abs
total_movement = 0
(1...period).each do |i|
  total_movement += (prices[-i] - prices[-(i+1)]).abs
end

efficiency = total_movement > 0 ? price_change / total_movement : 0

puts "Market Efficiency: #{(efficiency * 100).round(2)}%"

if efficiency > 0.5
  puts "HIGH EFFICIENCY - Strong trending market"
  puts "KAMA will be more responsive"
elsif efficiency < 0.2
  puts "LOW EFFICIENCY - Choppy market"
  puts "KAMA will be smoother, fewer signals"
else
  puts "MODERATE EFFICIENCY - Mixed market conditions"
end
```

## Example: Multi-Timeframe KAMA

```ruby
# Assuming different timeframe data
daily_prices = load_historical_prices('MSFT', timeframe: 'daily')
weekly_prices = load_historical_prices('MSFT', timeframe: 'weekly')

daily_kama = SQA::TAI.kama(daily_prices, period: 20)
weekly_kama = SQA::TAI.kama(weekly_prices, period: 20)

daily_price = daily_prices.last
weekly_price = weekly_prices.last

daily_trend = daily_price > daily_kama.last ? "UP" : "DOWN"
weekly_trend = weekly_price > weekly_kama.last ? "UP" : "DOWN"

puts "Daily trend: #{daily_trend}"
puts "Weekly trend: #{weekly_trend}"

if daily_trend == "UP" && weekly_trend == "UP"
  puts "ALIGNED UPTREND - Strongest bullish setup"
elsif daily_trend == "DOWN" && weekly_trend == "DOWN"
  puts "ALIGNED DOWNTREND - Strongest bearish setup"
else
  puts "CONFLICTING TRENDS - Wait for alignment"
end
```

## Advantages Over Traditional Moving Averages

1. **Adaptive**: Automatically adjusts to market conditions
2. **Reduced Whipsaws**: Slows down in choppy markets
3. **Timely in Trends**: Responds quickly in trending markets
4. **Self-Optimizing**: No need to constantly adjust parameters

## Common Settings

| Period | Use Case |
|--------|----------|
| 10 | Short-term, highly adaptive |
| 20 | Standard intraday and swing trading |
| 30 | Medium-term position trading (default) |
| 50+ | Long-term trend identification |

## Best Practices

1. **Combine with Volume**: Confirm KAMA signals with volume
2. **Use Multiple Timeframes**: Check alignment across timeframes
3. **Wait for Confirmed Breaks**: Avoid false signals at KAMA touches
4. **Consider Market Regime**: KAMA works best in markets with clear trend/range cycles

## Related Indicators

- [EMA](ema.md) - Exponential Moving Average
- [DEMA](dema.md) - Double Exponential Moving Average
- [TEMA](tema.md) - Triple Exponential Moving Average
- [T3](t3.md) - Tillson T3 Moving Average
- [MAMA](../volatility/mama.md) - MESA Adaptive Moving Average

## See Also

- [Back to Indicators](../index.md)
- [Overlap Studies Overview](../index.md)
