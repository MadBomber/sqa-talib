# SQA::TAI - Technical Analysis Indicators

Welcome to **SQA::TAI**, a Ruby wrapper around the legendary [TA-Lib](https://ta-lib.org/) C library, providing **132 technical analysis indicators** with a clean Ruby API.

## Overview

SQA::TAI is part of the [SQA (Simple Qualitative Analysis)](https://github.com/MadBomber/sqa) ecosystem, focusing on providing fast, reliable technical indicators for stock market analysis.

## Features

- **132 Indicators** - Comprehensive coverage with 94% of trading-relevant TA-Lib indicators
- **Blazing Fast** - C library performance with Ruby convenience
- **Clean API** - Simple, intuitive interface with keyword arguments
- **Well Tested** - 73 tests, 332 assertions, comprehensive coverage
- **Type Safe** - Parameter validation and error handling
- **Bug Fixed** - Includes monkey patch for ta_lib_ffi 0.3.0 multi-array parameter bug

## Quick Example

```ruby
require 'sqa/tai'

prices = [44.34, 44.09, 44.15, 43.61, 44.33, 44.83,
          45.10, 45.42, 45.84, 46.08]

# Calculate indicators
sma = SQA::TAI.sma(prices, period: 5)
rsi = SQA::TAI.rsi(prices, period: 14)
upper, middle, lower = SQA::TAI.bbands(prices, period: 20)

puts "SMA: #{sma.last}"
puts "RSI: #{rsi.last}"
```

## Installation

First, install the TA-Lib C library:

=== "macOS"
    ```bash
    brew install ta-lib
    ```

=== "Ubuntu/Debian"
    ```bash
    wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
    tar -xzf ta-lib-0.4.0-src.tar.gz
    cd ta-lib/
    ./configure --prefix=/usr
    make
    sudo make install
    ```

=== "Windows"
    Download from [ta-lib.org](https://ta-lib.org/hdr_dw.html)

Then install the gem:

```bash
gem install sqa-tai
```

## Indicator Categories (132 Total)

### Overlap Studies (15)
Moving averages and bands for trend analysis:

- [SMA](indicators/overlap/sma.md) - Simple Moving Average
- [EMA](indicators/overlap/ema.md) - Exponential Moving Average
- [WMA](indicators/overlap/wma.md) - Weighted Moving Average
- **DEMA** - Double Exponential Moving Average
- **TEMA** - Triple Exponential Moving Average
- **TRIMA** - Triangular Moving Average
- **KAMA** - Kaufman Adaptive Moving Average
- **T3** - Triple Exponential Moving Average (T3)
- [BBANDS](indicators/overlap/bbands.md) - Bollinger Bands
- **SAREXT** - Parabolic SAR Extended
- **HT_TRENDLINE** - Hilbert Transform Instantaneous Trendline
- **MAMA** - MESA Adaptive Moving Average
- **MAVP** - Moving Average with Variable Period
- **MIDPOINT** - Midpoint over period
- **MIDPRICE** - Midpoint Price over period

### Momentum Indicators (30)
Measure rate of price change:

- [RSI](indicators/momentum/rsi.md) - Relative Strength Index
- [MACD](indicators/momentum/macd.md) - Moving Average Convergence/Divergence
- [STOCH](indicators/momentum/stoch.md) - Stochastic Oscillator
- [MOM](indicators/momentum/mom.md) - Momentum
- **CCI** - Commodity Channel Index
- **WILLR** - Williams' %R
- **ROC** - Rate of Change
- **ROCP** - Rate of Change Percentage
- **ROCR** - Rate of Change Ratio
- **PPO** - Percentage Price Oscillator
- **ADX** - Average Directional Index
- **ADXR** - Average Directional Movement Index Rating
- **APO** - Absolute Price Oscillator
- **AROON** - Aroon Indicator
- **AROONOSC** - Aroon Oscillator
- **BOP** - Balance of Power
- **CMO** - Chande Momentum Oscillator
- **DX** - Directional Movement Index
- **MACDEXT** - MACD with Controllable MA Type
- **MACDFIX** - MACD Fix 12/26
- **MFI** - Money Flow Index
- **MINUS_DI** - Minus Directional Indicator
- **MINUS_DM** - Minus Directional Movement
- **PLUS_DI** - Plus Directional Indicator
- **PLUS_DM** - Plus Directional Movement
- **ROCR100** - Rate of Change Ratio 100 scale
- **STOCHF** - Stochastic Fast
- **STOCHRSI** - Stochastic RSI
- **TRIX** - 1-day ROC of Triple Smooth EMA
- **ULTOSC** - Ultimate Oscillator

### Volatility Indicators (4)
Measure price volatility:

- [ATR](indicators/volatility/atr.md) - Average True Range
- **NATR** - Normalized Average True Range
- [TRANGE](indicators/volatility/trange.md) - True Range
- **SAR** - Parabolic SAR

### Volume Indicators (3)
Analyze trading volume:

- [OBV](indicators/volume/obv.md) - On Balance Volume
- [AD](indicators/volume/ad.md) - Chaikin A/D Line
- **ADOSC** - Chaikin A/D Oscillator

### Price Transform (4)
Price averaging and transformation:

- **AVGPRICE** - Average Price
- **MEDPRICE** - Median Price
- **TYPPRICE** - Typical Price
- **WCLPRICE** - Weighted Close Price

### Cycle Indicators (5)
Identify market cycles:

- **HT_DCPERIOD** - Hilbert Transform - Dominant Cycle Period
- **HT_TRENDMODE** - Hilbert Transform - Trend vs Cycle Mode
- **HT_DCPHASE** - Hilbert Transform - Dominant Cycle Phase
- **HT_PHASOR** - Hilbert Transform - Phasor Components
- **HT_SINE** - Hilbert Transform - SineWave

### Statistical Functions (9)
Statistical analysis and regression:

- **CORREL** - Pearson's Correlation Coefficient
- **BETA** - Beta Coefficient
- **VAR** - Variance
- **STDDEV** - Standard Deviation
- **LINEARREG** - Linear Regression
- **LINEARREG_ANGLE** - Linear Regression Angle
- **LINEARREG_INTERCEPT** - Linear Regression Intercept
- **LINEARREG_SLOPE** - Linear Regression Slope
- **TSF** - Time Series Forecast

### Pattern Recognition (61)
Identify candlestick patterns:

- [Doji](indicators/patterns/doji.md) - Doji Pattern
- [Hammer](indicators/patterns/hammer.md) - Hammer Pattern
- [Engulfing](indicators/patterns/engulfing.md) - Engulfing Pattern
- **Morning Star** - Morning Star Pattern
- **Evening Star** - Evening Star Pattern
- **Harami** - Harami Pattern
- **Piercing** - Piercing Pattern
- **Shooting Star** - Shooting Star Pattern
- **Marubozu** - Marubozu Pattern
- **Spinning Top** - Spinning Top Pattern
- **Dragonfly Doji** - Dragonfly Doji Pattern
- **Gravestone Doji** - Gravestone Doji Pattern
- **Two Crows** - Two Crows Pattern
- **Three Black Crows** - Three Black Crows Pattern
- **Three Inside** - Three Inside Up/Down Pattern
- **Three Line Strike** - Three Line Strike Pattern
- **Three Outside** - Three Outside Up/Down Pattern
- **Three White Soldiers** - Three Advancing White Soldiers
- **Dark Cloud Cover** - Dark Cloud Cover Pattern
- **Abandoned Baby** - Abandoned Baby Pattern
- **Hanging Man** - Hanging Man Pattern
- **Inverted Hammer** - Inverted Hammer Pattern
- **Kicking** - Kicking Pattern
- **Morning Doji Star** - Morning Doji Star Pattern
- **Evening Doji Star** - Evening Doji Star Pattern
- **High Wave** - High-Wave Candle Pattern
- **Hikkake** - Hikkake Pattern
- **Rickshaw Man** - Rickshaw Man Pattern
- **Takuri** - Takuri (Dragonfly Doji with very long lower shadow)
- **Tristar** - Tristar Pattern
- And 32 more candlestick patterns...

## SQA Ecosystem

SQA::TAI is part of a larger ecosystem:

- **[sqa](https://github.com/MadBomber/sqa)** - Trading strategy framework
- **[sqa-tai](https://github.com/MadBomber/sqa-tai)** - Technical indicators (this gem)
- **[sqa-cli](https://github.com/MadBomber/sqa-cli)** - CLI tool with AI integration

## Next Steps

- [Installation Guide](getting-started/installation.md)
- [Quick Start Tutorial](getting-started/quick-start.md)
- [API Reference](api-reference.md)
- [Examples](examples/trend-analysis.md)

## Support

- **GitHub**: [Issues](https://github.com/MadBomber/sqa-tai/issues)
- **Email**: dvanhoozer@gmail.com

## License

MIT License - see [LICENSE](https://github.com/MadBomber/sqa-tai/blob/main/LICENSE) for details.
