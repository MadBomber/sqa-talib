# Triangular Moving Average (TRIMA)

The Triangular Moving Average (TRIMA) is a double-smoothed simple moving average that places more weight on the middle portion of the data series. It provides a smoother curve than a simple moving average and is particularly useful for identifying longer-term trends.

## Formula

TRIMA is calculated by taking a Simple Moving Average (SMA) of another SMA:

- For odd periods (n): SMA of SMA over (n+1)/2 periods
- For even periods (n): SMA of SMA over n/2 periods

This double-smoothing creates a triangular weight distribution where the middle values have the highest influence.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prices` | Array<Float> | Yes | - | Array of price values |
| `period` | Integer | No | 30 | Number of periods for calculation |

## Returns

Returns an array of TRIMA values. The first several values will be `nil` due to the double-smoothing calculation.

## Usage

```ruby
require 'sqa/tai'

prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08, 46.03, 46.41,
          46.22, 45.64, 46.21, 46.25, 46.08, 46.46,
          46.82, 47.00, 47.32, 47.20, 47.57, 47.80,
          48.00, 48.15, 48.30, 48.40, 48.55, 48.70,
          48.85, 49.00]

# Calculate 30-period TRIMA (default)
trima = SQA::TAI.trima(prices)

# Calculate 20-period TRIMA
trima_20 = SQA::TAI.trima(prices, period: 20)

puts "Current TRIMA: #{trima.last.round(2)}"
```

## Interpretation

The TRIMA provides a very smooth representation of price trends:

- **Price above TRIMA**: Indicates uptrend
- **Price below TRIMA**: Indicates downtrend
- **TRIMA slope**: Shows trend direction and strength
- **Flat TRIMA**: Suggests consolidation or range-bound market

## Example: TRIMA Trend Filter

```ruby
prices = load_historical_prices('SPY')
trima = SQA::TAI.trima(prices, period: 50)

current_price = prices.last
current_trima = trima.last
trima_5_bars_ago = trima[-5]

# Determine trend
if current_trima > trima_5_bars_ago
  trend_direction = "BULLISH"
elsif current_trima < trima_5_bars_ago
  trend_direction = "BEARISH"
else
  trend_direction = "NEUTRAL"
end

# Position relative to TRIMA
position = current_price > current_trima ? "ABOVE" : "BELOW"

puts "Trend: #{trend_direction}"
puts "Price is #{position} TRIMA"
puts "TRIMA value: #{current_trima.round(2)}"
```

## Example: TRIMA Support/Resistance

```ruby
prices = load_historical_prices('AAPL')
trima = SQA::TAI.trima(prices, period: 30)

# Look for price approaching TRIMA
current_price = prices.last
current_trima = trima.last
distance_pct = ((current_price - current_trima) / current_trima * 100).abs

if distance_pct < 0.5
  if prices[-2] > trima[-2]
    puts "Price approaching TRIMA from above - potential support"
  else
    puts "Price approaching TRIMA from below - potential resistance"
  end
elsif distance_pct > 3
  puts "Price extended #{distance_pct.round(2)}% from TRIMA"
  puts "Potential mean reversion opportunity"
end
```

## Example: TRIMA with Envelope Bands

```ruby
prices = load_historical_prices('MSFT')
trima = SQA::TAI.trima(prices, period: 20)

# Create envelope bands (e.g., 2% above/below TRIMA)
envelope_pct = 2.0
upper_band = trima.map { |v| v.nil? ? nil : v * (1 + envelope_pct / 100) }
lower_band = trima.map { |v| v.nil? ? nil : v * (1 - envelope_pct / 100) }

current_price = prices.last

if current_price > upper_band.last
  puts "Price above upper envelope - potential overbought"
elsif current_price < lower_band.last
  puts "Price below lower envelope - potential oversold"
else
  puts "Price within envelope - normal range"
end
```

## Characteristics

### Advantages:
1. **Very Smooth**: Double-smoothing eliminates most noise
2. **Centered Weight**: Middle values have most influence
3. **Stable**: Less prone to whipsaws than faster MAs
4. **Clear Trends**: Excellent for identifying major trend changes

### Disadvantages:
1. **High Lag**: Significant delay in responding to price changes
2. **Late Signals**: May miss early entry opportunities
3. **Not for Short-term**: Too slow for day trading or scalping

## Common Settings

| Period | Use Case |
|--------|----------|
| 10-20 | Short to medium-term trends |
| 30-50 | Standard trend identification |
| 100+ | Major long-term trends only |

## Best Use Cases

The TRIMA works best for:
- **Long-term position trading**: Where smoothness matters more than speed
- **Trend identification**: Filtering out short-term noise
- **Market structure analysis**: Understanding overall market direction
- **Confirmation tool**: Used with faster indicators for entry/exit

## Related Indicators

- [SMA](sma.md) - Simple Moving Average
- [EMA](ema.md) - Exponential Moving Average
- [DEMA](dema.md) - Double Exponential Moving Average
- [WMA](wma.md) - Weighted Moving Average

## See Also

- [Back to Indicators](../index.md)
- [Overlap Studies Overview](../index.md)
