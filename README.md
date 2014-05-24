[![Build Status](https://travis-ci.org/milktrader/Quandl.jl.png)](https://travis-ci.org/milktrader/Quandl.jl)
[![Package Evaluator](http://iainnz.github.io/packages.julialang.org/badges/Quandl_0.3.svg)](http://iainnz.github.io/packages.julialang.org/?pkg=Quandl&ver=0.3)

## Julia API to Quandl 

[Quandl.com](http://www.quandl.com) is a lightweight interface to over seven million open-source datasets. 

You can use this package without an auth token, but it's recommended you get one from Quandl.com. You are limited to 10 downloads per day
without your unique token. Once you get a token, you'll only need to replace the text in the `src/token/auth_token.jl` file with your unique 
token. Don't leave any whitespace or extra lines.  Every time you upgrade or re-install this package, you'll need to do this extra step. 

The package will use your unique token automatically, or if you choose to remain anonymous and don't care about more than 10 downloads per day, it
will make an anonymous call. 

````julia
Pkg.add("Quandl")
````

The `quandl` method takes one positional argument and currently supports three keyword arguments, `period`, `rows` and `format`. The positional
argument is the Quandl code for the database you wish to download. 


````julia
julia> quandl("GOOG/NASDAQ_QQQ") 
100x5 TimeArray{Float64,2} 2013-12-31 to 2014-05-23

             Open   High   Low    Close  Volume
2013-12-31 | 87.54  87.96  87.52  87.96  2.4896065e7
2014-01-02 | 87.55  87.58  87.02  87.27  2.9190009e7
2014-01-03 | 87.27  87.35  86.62  86.64  3.5727317e7
2014-01-06 | 86.65  86.76  86.0   86.32  3.2092437e7
⋮
2014-05-20 | 88.28  88.6   87.64  88.0   3.3715953e7
2014-05-21 | 88.16  88.89  88.11  88.84  3.6837678e7
2014-05-22 | 88.94  89.48  88.8   89.23  3.0617089e7
2014-05-23 | 89.33  89.9   89.12  89.88  2.2691254e7
````

Support for DataFrames is planned. 
