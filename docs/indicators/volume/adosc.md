# Chaikin A/D Oscillator (ADOSC)

The Chaikin A/D Oscillator is a momentum indicator that measures the accumulation-distribution line using the difference between two exponential moving averages. It combines price and volume to show the flow of money into or out of a security.

## Formula

ADOSC = EMA(AD, fast_period) - EMA(AD, slow_period)

Where AD is the Accumulation/Distribution Line.

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `high` | Array<Float> | Yes | - | Array of high prices |
| `low` | Array<Float> | Yes | - | Array of low prices |
| `close` | Array<Float> | Yes | - | Array of close prices |
| `volume` | Array<Float> | Yes | - | Array of volume values |
| `fast_period` | Integer | No | 3 | Fast EMA period |
| `slow_period` | Integer | No | 10 | Slow EMA period |

## Returns

Returns an array of ADOSC values.

## Usage

```ruby
require 'sqa/tai'

high =   [48.70, 48.72, 48.90, 48.87, 48.82]
low =    [47.79, 48.14, 48.39, 48.37, 48.24]
close =  [48.20, 48.61, 48.75, 48.63, 48.74]
volume = [10000, 12000, 11500, 13000, 11000]

adosc = SQA::TAI.adosc(high, low, close, volume, fast_period: 3, slow_period: 10)

puts "Current ADOSC: #{adosc.last.round(2)}"
```

## Interpretation

- **Positive ADOSC**: Buying pressure (accumulation)
- **Negative ADOSC**: Selling pressure (distribution)
- **Rising ADOSC**: Increasing buying pressure
- **Falling ADOSC**: Increasing selling pressure
- **Divergence**: Price/ADOSC divergence signals potential reversals

## Example: ADOSC Trend Confirmation

```ruby
high, low, close, volume = load_historical_ohlcv('AAPL')
adosc = SQA::TAI.adosc(high, low, close, volume, fast_period: 3, slow_period: 10)

current_adosc = adosc.last
price_trend = close.last > close[-10] ? "UP" : "DOWN"

if price_trend == "UP" && current_adosc > 0
  puts "STRONG UPTREND - Price and ADOSC both positive"
elsif price_trend == "DOWN" && current_adosc < 0
  puts "STRONG DOWNTREND - Price and ADOSC both negative"
elsif price_trend == "UP" && current_adosc < 0
  puts "WEAK UPTREND - Negative divergence warning"
elsif price_trend == "DOWN" && current_adosc > 0
  puts "WEAK DOWNTREND - Positive divergence warning"
end
```

## Common Settings

| Fast | Slow | Use Case |
|------|------|----------|
| 3 | 10 | Standard (most common) |
| 5 | 15 | Less volatile |
| 2 | 7 | More sensitive |

## Related Indicators

- [AD](ad.md) - Chaikin A/D Line
- [OBV](obv.md) - On Balance Volume

## See Also

- [Back to Indicators](../index.md)
- [Volume Indicators Overview](../index.md)
