# Triple Exponential Moving Average (TEMA)

The Triple Exponential Moving Average (TEMA) is a technical indicator designed to smooth price data and reduce lag even more than the Double Exponential Moving Average (DEMA). It provides a highly responsive moving average that closely follows price action.

## Formula

TEMA = 3 * EMA(n) - 3 * EMA(EMA(n)) + EMA(EMA(EMA(n)))

Where n is the time period. The TEMA applies the EMA calculation three times with a weighted combination to minimize lag while maintaining smoothness.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of price values |
| `period` | Integer | No | 30 | Number of periods for calculation |

## Returns

Returns an array of TEMA values. The first several values will be `nil` due to the calculation requiring sufficient data points.

## Usage

```ruby
require 'sqa/tai'

prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08, 46.03, 46.41,
          46.22, 45.64, 46.21, 46.25, 46.08, 46.46,
          46.82, 47.00, 47.32, 47.20, 47.57, 47.80,
          48.00, 48.15, 48.30, 48.40, 48.55, 48.70,
          48.85, 49.00]

# Calculate 30-period TEMA (default)
tema = SQA::TAI.tema(prices)

# Calculate 10-period TEMA for maximum responsiveness
tema_10 = SQA::TAI.tema(prices, period: 10)

puts "Current TEMA: #{tema.last.round(2)}"
```

## Interpretation

The TEMA is one of the most responsive moving averages while still filtering out noise:

- **Price above TEMA**: Strong uptrend signal
- **Price below TEMA**: Strong downtrend signal
- **TEMA slope**: Indicates trend strength and direction
- **Price touching TEMA**: Potential support/resistance levels

## Example: TEMA Trend Following

```ruby
prices = load_historical_prices('MSFT')
tema = SQA::TAI.tema(prices, period: 20)

current_price = prices.last
current_tema = tema.last
previous_tema = tema[-2]

# Trend direction
if current_tema > previous_tema
  trend = "UP"
elsif current_tema < previous_tema
  trend = "DOWN"
else
  trend = "FLAT"
end

# Position relative to TEMA
if current_price > current_tema
  puts "#{trend}TREND - Price above TEMA: BULLISH"
elsif current_price < current_tema
  puts "#{trend}TREND - Price below TEMA: BEARISH"
else
  puts "#{trend}TREND - Price at TEMA: NEUTRAL"
end
```

## Example: TEMA with Multiple Timeframes

```ruby
prices = load_historical_prices('AAPL')

# Fast TEMA for entry signals
tema_fast = SQA::TAI.tema(prices, period: 8)

# Slow TEMA for trend direction
tema_slow = SQA::TAI.tema(prices, period: 21)

fast_value = tema_fast.last
slow_value = tema_slow.last

if fast_value > slow_value
  puts "Fast TEMA above Slow TEMA - UPTREND"
  puts "Look for pullbacks to fast TEMA for entries"
elsif fast_value < slow_value
  puts "Fast TEMA below Slow TEMA - DOWNTREND"
  puts "Look for rallies to fast TEMA for short entries"
end
```

## Example: TEMA Breakout System

```ruby
prices = load_historical_prices('TSLA')
tema = SQA::TAI.tema(prices, period: 15)

# Calculate distance from TEMA
distances = prices.last(20).zip(tema.last(20)).map do |price, tema_val|
  next nil if tema_val.nil?
  ((price - tema_val) / tema_val * 100).abs
end.compact

avg_distance = distances.sum / distances.size

current_distance = ((prices.last - tema.last) / tema.last * 100).abs

if current_distance > avg_distance * 2
  puts "Price extended #{current_distance.round(2)}% from TEMA"
  puts "Potential breakout or exhaustion move"
elsif current_distance < avg_distance * 0.5
  puts "Price compressed near TEMA"
  puts "Potential consolidation before next move"
end
```

## Advantages

1. **Minimal Lag**: Among the most responsive moving averages
2. **Smooth**: Filters out most noise despite responsiveness
3. **Clear Signals**: Generates fewer false signals than simple fast EMAs
4. **Versatile**: Works well in trending and ranging markets

## Common Settings

| Period | Use Case |
|--------|----------|
| 5-8 | Scalping and very short-term trading |
| 10-15 | Day trading and swing trading |
| 20-30 | Position trading (standard) |
| 50+ | Long-term trend identification |

## Comparison with Other Moving Averages

| MA Type | Lag | Smoothness | Best For |
|---------|-----|------------|----------|
| SMA | High | High | Long-term trends |
| EMA | Medium | Medium | General trading |
| DEMA | Low | Medium | Active trading |
| TEMA | Very Low | Medium | Short-term trading |
| T3 | Low | Very High | Smooth trends |

## Related Indicators

- [DEMA](dema.md) - Double Exponential Moving Average
- [EMA](ema.md) - Exponential Moving Average
- [T3](t3.md) - Tillson T3 Moving Average
- [SMA](sma.md) - Simple Moving Average

## See Also

- [Back to Indicators](../index.md)
- [Overlap Studies Overview](../index.md)
