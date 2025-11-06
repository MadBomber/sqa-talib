# Average Directional Index (ADX)

The Average Directional Index (ADX) measures the strength of a trend, regardless of its direction. It's part of the Directional Movement System developed by J. Welles Wilder and is one of the most reliable trend strength indicators.

## Formula

ADX is derived from the smoothed averages of the difference between +DI and -DI:
1. Calculate +DM and -DM (directional movement)
2. Calculate +DI and -DI (directional indicators)
3. Calculate DX = |(+DI - -DI)| / (+DI + -DI) * 100
4. ADX = smoothed average of DX

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |
| `period` | Integer | No | 14 | Number of periods |

## Returns

Returns an array of ADX values ranging from 0 to 100.

## Usage

```ruby
require 'sqa/tai'

high =  [48.70, 48.72, 48.90, 48.87, 48.82, 49.05, 49.20, 49.35, 49.92, 50.19, 50.12, 50.10, 50.00, 49.75, 49.80]
low =   [47.79, 48.14, 48.39, 48.37, 48.24, 48.64, 48.94, 49.03, 49.50, 49.87, 49.20, 49.00, 48.90, 49.00, 49.10]
close = [48.20, 48.61, 48.75, 48.63, 48.74, 49.03, 49.07, 49.32, 49.91, 50.13, 49.53, 49.50, 49.25, 49.20, 49.45]

adx = SQA::TAI.adx(high, low, close, period: 14)

puts "Current ADX: #{adx.last.round(2)}"
```

## Interpretation

| ADX Value | Trend Strength |
|-----------|----------------|
| 0-25 | Absent or weak trend |
| 25-50 | Strong trend |
| 50-75 | Very strong trend |
| 75-100 | Extremely strong trend |

**Important**: ADX does NOT indicate trend direction, only strength!

## Example: Trend Strength Analysis

```ruby
high, low, close = load_historical_ohlc('AAPL')
adx = SQA::TAI.adx(high, low, close, period: 14)

current_adx = adx.last

if current_adx > 50
  puts "VERY STRONG TREND (ADX: #{current_adx.round(2)})"
  puts "Consider trend-following strategies"
elsif current_adx > 25
  puts "STRONG TREND (ADX: #{current_adx.round(2)})"
  puts "Good conditions for trend trading"
elsif current_adx > 20
  puts "DEVELOPING TREND (ADX: #{current_adx.round(2)})"
  puts "Watch for trend development"
else
  puts "WEAK/NO TREND (ADX: #{current_adx.round(2)})"
  puts "Range-bound - use oscillators instead"
end
```

## Example: ADX with Directional Indicators

```ruby
high, low, close = load_historical_ohlc('SPY')

adx = SQA::TAI.adx(high, low, close, period: 14)
plus_di = SQA::TAI.plus_di(high, low, close, period: 14)
minus_di = SQA::TAI.minus_di(high, low, close, period: 14)

current_adx = adx.last
current_plus = plus_di.last
current_minus = minus_di.last

if current_adx > 25
  if current_plus > current_minus
    puts "STRONG UPTREND"
    puts "ADX: #{current_adx.round(2)}, +DI: #{current_plus.round(2)}, -DI: #{current_minus.round(2)}"
  else
    puts "STRONG DOWNTREND"
    puts "ADX: #{current_adx.round(2)}, +DI: #{current_plus.round(2)}, -DI: #{current_minus.round(2)}"
  end
else
  puts "WEAK TREND - Range-bound market"
  puts "ADX: #{current_adx.round(2)}"
end
```

## Example: ADX Rising/Falling

```ruby
high, low, close = load_historical_ohlc('MSFT')
adx = SQA::TAI.adx(high, low, close, period: 14)

current_adx = adx.last
adx_5_bars_ago = adx[-5]

adx_change = current_adx - adx_5_bars_ago

if current_adx > 25 && adx_change > 0
  puts "ADX RISING in strong trend - Trend gaining strength"
elsif current_adx > 25 && adx_change < 0
  puts "ADX FALLING in strong trend - Trend weakening"
elsif current_adx < 25 && adx_change > 0
  puts "ADX RISING from weak - New trend developing"
else
  puts "ADX FALLING in weak trend - Continued consolidation"
end
```

## Common Settings

| Period | Use Case |
|--------|----------|
| 14 | Standard (Wilder's original) |
| 7 | More sensitive to trend changes |
| 21 | Smoother, longer-term trends |

## Trading Strategies

### 1. Trend Filter
- Trade only when ADX > 25 (strong trend)
- Use range strategies when ADX < 20

### 2. Trend Development
- Buy when ADX crosses above 20 with +DI > -DI
- Sell when ADX crosses above 20 with -DI > +DI

### 3. Trend Exhaustion
- Watch for ADX > 50 then starting to decline
- May signal trend exhaustion

## Related Indicators

- [ADXR](adxr.md) - ADX Rating
- [PLUS_DI](plus_di.md) - Plus Directional Indicator
- [MINUS_DI](minus_di.md) - Minus Directional Indicator
- [DX](dx.md) - Directional Movement Index

## See Also

- [Back to Indicators](../index.md)
- [Momentum Indicators Overview](../index.md)
