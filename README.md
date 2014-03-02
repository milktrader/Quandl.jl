[![Build Status](https://travis-ci.org/milktrader/Quandl.jl.png)](https://travis-ci.org/milktrader/Quandl.jl)

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
100  4350  100  4350    0     0   2448      0  0:00:01  0:00:01 --:--:--  2447
100x5 TimeArray{Float64,2} 1999-03-10 to 1999-07-30

             Open   High    Low     Close   Volume
1999-03-10 | 0.000  51.160  50.280  51.060  5232200.000
1999-03-11 | 0.000  51.730  50.310  51.310  9688600.000
1999-03-12 | 0.000  51.160  49.660  50.060  8743600.000
1999-03-15 | 0.000  51.560  49.910  51.500  6369000.000
...
1999-07-26 | 0.000  57.120  55.780  55.880  10720000.000
1999-07-27 | 0.000  57.880  56.520  57.000  13732800.000
1999-07-28 | 0.000  58.440  56.950  58.120  10161800.000
1999-07-29 | 0.000  57.500  56.310  56.880  13033800.000
1999-07-30 | 0.000  57.750  56.510  56.590  10947400.000
````

TimeSeries currently has issues showing lengthy row names.

Support for DataFrames is planned. 
