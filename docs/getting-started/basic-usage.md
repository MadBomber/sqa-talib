# Basic Usage

Learn the fundamentals of using SQA::TAI in your Ruby applications.

## Requiring the Library

```ruby
require 'sqa/tai'
```

## Simple Indicator Calculation

```ruby
# Sample price data
prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08, 46.03, 46.41,
          46.22, 45.64, 46.21, 46.25, 46.08, 46.46,
          46.57, 45.95]

# Calculate Simple Moving Average
sma = SQA::TAI.sma(prices, period: 5)

# Calculate Relative Strength Index
rsi = SQA::TAI.rsi(prices, period: 14)

# Calculate Bollinger Bands (returns three arrays)
upper, middle, lower = SQA::TAI.bbands(prices, period: 20)
```

## Working with Multiple Return Values

Some indicators return multiple arrays:

```ruby
# MACD returns three arrays: macd line, signal line, histogram
macd, signal, histogram = SQA::TAI.macd(prices)

# Bollinger Bands returns three arrays: upper, middle, lower
upper, middle, lower = SQA::TAI.bbands(prices, period: 20)

# Stochastic returns two arrays: slowk, slowd
slowk, slowd = SQA::TAI.stoch(high, low, close)
```

## Using Keyword Arguments

All parameters use keyword arguments for clarity:

```ruby
# Explicit parameter names
sma = SQA::TAI.sma(prices, period: 10)
ema = SQA::TAI.ema(prices, period: 12)
rsi = SQA::TAI.rsi(prices, period: 14)

# Custom Bollinger Bands settings
upper, middle, lower = SQA::TAI.bbands(
  prices,
  period: 20,
  nbdev_up: 2.0,
  nbdev_down: 2.0
)
```

## Working with OHLC Data

For candlestick patterns and some indicators, you need OHLC (Open, High, Low, Close) data:

```ruby
# OHLC arrays (all must be same length)
open   = [100.0, 101.0, 102.0, 101.5, 103.0]
high   = [102.0, 103.0, 104.0, 103.0, 105.0]
low    = [99.5, 100.0, 101.0, 100.5, 102.0]
close  = [101.0, 102.0, 101.5, 103.0, 104.0]

# Calculate Average True Range
atr = SQA::TAI.atr(high, low, close, period: 14)

# Detect candlestick patterns
doji = SQA::TAI.cdl_doji(open, high, low, close)
hammer = SQA::TAI.cdl_hammer(open, high, low, close)
```

## Handling Return Values

Indicators return arrays, typically with leading nil values for the warmup period:

```ruby
prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08]

# 5-period SMA requires 5 values to start calculating
sma = SQA::TAI.sma(prices, period: 5)

# sma will have nils for first 4 values:
# [nil, nil, nil, nil, 44.904, 45.118, ...]

# Get the most recent value
current_sma = sma.last

# Get valid values only
valid_sma = sma.compact
```

## Error Handling

```ruby
begin
  result = SQA::TAI.sma(prices, period: 30)
rescue SQA::TAI::TAINotInstalledError => e
  puts "TA-Lib C library not found: #{e.message}"
  puts "Install with: brew install ta-lib"
rescue SQA::TAI::InvalidParameterError => e
  puts "Invalid parameters: #{e.message}"
rescue => e
  puts "Unexpected error: #{e.message}"
end
```

## Checking Availability

```ruby
# Check if TA-Lib is properly installed
if SQA::TAI.available?
  puts "TA-Lib is ready to use!"
else
  puts "TA-Lib not found. Please install it first."
end
```

## Common Patterns

### Moving Average Crossover

```ruby
prices = load_historical_prices('AAPL')

# Calculate two moving averages
fast_ma = SQA::TAI.sma(prices, period: 50)
slow_ma = SQA::TAI.sma(prices, period: 200)

# Check for golden cross
if fast_ma[-2] < slow_ma[-2] && fast_ma[-1] > slow_ma[-1]
  puts "Golden Cross detected - Bullish signal!"
end
```

### RSI Overbought/Oversold

```ruby
prices = load_historical_prices('TSLA')
rsi = SQA::TAI.rsi(prices, period: 14)

case rsi.last
when 0...30
  puts "Oversold - potential buy signal"
when 70..100
  puts "Overbought - potential sell signal"
else
  puts "Neutral"
end
```

### Bollinger Band Squeeze

```ruby
prices = load_historical_prices('MSFT')
upper, middle, lower = SQA::TAI.bbands(prices, period: 20)

# Calculate band width
bandwidth = upper.last - lower.last
price = prices.last

if price > upper.last
  puts "Price above upper band - overbought"
elsif price < lower.last
  puts "Price below lower band - oversold"
else
  puts "Price within bands - normal"
end
```

### Advanced Moving Averages

```ruby
prices = load_historical_prices('GOOGL')

# Double Exponential Moving Average (faster response)
dema = SQA::TAI.dema(prices, period: 20)

# Kaufman Adaptive Moving Average (adapts to market conditions)
kama = SQA::TAI.kama(prices, period: 30)

# Triple Exponential Moving Average T3 (smooth)
t3 = SQA::TAI.t3(prices, period: 5, vfactor: 0.7)
```

### Statistical Analysis

```ruby
stock_prices = load_historical_prices('AAPL')
market_prices = load_historical_prices('SPY')

# Calculate correlation between stock and market
correlation = SQA::TAI.correl(stock_prices, market_prices, period: 30)
puts "Correlation: #{correlation.last}"

# Calculate beta (systematic risk)
beta = SQA::TAI.beta(stock_prices, market_prices, period: 30)
puts "Beta: #{beta.last}"

# Calculate standard deviation (volatility)
stddev = SQA::TAI.stddev(stock_prices, period: 20)
puts "Volatility: #{stddev.last}"
```

### Cycle Detection

```ruby
prices = load_historical_prices('BTC-USD')

# Detect dominant cycle period
cycle_period = SQA::TAI.ht_dcperiod(prices)
puts "Dominant cycle: #{cycle_period.last} days"

# Detect trend vs cycle mode
trend_mode = SQA::TAI.ht_trendmode(prices)
if trend_mode.last == 1
  puts "Market is trending"
else
  puts "Market is cycling/ranging"
end
```

### Multiple Candlestick Patterns

```ruby
# Detect various reversal patterns
morning_star = SQA::TAI.cdl_morningstar(open, high, low, close)
evening_star = SQA::TAI.cdl_eveningstar(open, high, low, close)
harami = SQA::TAI.cdl_harami(open, high, low, close)

# Check for bullish reversal
if morning_star.last == 100
  puts "Morning Star detected - potential bullish reversal"
end

# Check for bearish reversal
if evening_star.last == -100
  puts "Evening Star detected - potential bearish reversal"
end
```

## Next Steps

- [Indicator Reference](../indicators/index.md) - Explore all available indicators
- [API Reference](../api-reference.md) - Detailed API documentation
- [Examples](../examples/trend-analysis.md) - Real-world usage examples
