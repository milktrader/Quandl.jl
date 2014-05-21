[![Build Status](https://travis-ci.org/milktrader/Quandl.jl.png)](https://travis-ci.org/milktrader/Quandl.jl)
[![Package Evaluator](http://iainnz.github.io/packages.julialang.org/badges/Quandl_0.3.svg)](http://iainnz.github.io/packages.julialang.org/?pkg=Quandl&ver=0.3)

## Julia API to Quandl 

[Quandl.com](http://www.quandl.com) is a lightweight interface to over seven million open-source datasets. 

You can use this package without an auth token, but it's recommended you get one from Quandl.com. You are limited to 10 downloads per day
without your unique token. A token gives you 100 calls per day. Once you get a token, you'll only need to replace the text in the 
`src/token/auth_token.jl` file with your unique token. Don't leave any whitespace or extra lines.  Every time you upgrade or re-install this 
package, you'll need to do this extra step. 

The package will use your unique token automatically, or if you choose to remain anonymous and don't care about more than 10 downloads per day, it
will make an anonymous call. 

Also note that support for Windows has not been tested.  The current way to download data is a bit of a hack, and Windows is likely 
not going to like it.

````julia
Pkg.add("Quandl")
````

The `quandl` method takes one positional argument and currently supports two keyword arguments, `period` and `rows`. The positional
argument is the Quandl code for the database you wish to download. 


````julia
julia> quandl("GOOG/NASDAQ_QQQ")
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  4590  100  4590    0     0   4513      0  0:00:01  0:00:01 --:--:--  4517
100x5 TimeArray{Float64,2} 2013-12-09 to 2014-05-02

             Open   High   Low    Close  Volume
2013-12-09 | 86.35  86.53  86.2   86.35  2.2599903e7
2013-12-10 | 86.2   86.45  86.12  86.29  2.6965928e7
2013-12-11 | 86.29  86.4   85.06  85.18  3.6830565e7
2013-12-12 | 85.23  85.42  84.9   84.96  3.3662597e7
⋮
2014-04-29 | 86.75  87.32  86.31  87.16  3.6742661e7
2014-04-30 | 86.79  87.48  86.54  87.39  3.8689408e7
2014-05-01 | 87.53  88.15  87.31  87.65  3.7127219e7
2014-05-02 | 87.94  88.11  87.28  87.49  4.007415e7
````

Support for DataFrames is planned. 
