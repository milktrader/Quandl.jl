## Julia API to Quandl 

[Quandl.com](http://www.quandl.com) is a lightweight interface to over 4 million open-source datasets. This package gives access to their api, and places the data into
a time-aware DataFrame.

You can use this package without an auth token, but it's recommended you get one from Quandl.com. You are limited to 10 downloads per day
without your unique token. A token gives you 100 calls per day. Once you get a token, you'll only need to replace the text in the 
`src/token/auth_token.jl` file with your unique token. Don't leave any whitespace or extra lines.  Every time you upgrade or re-install this 
package, you'll need to do this extra step. 

The package will use your unique token automatically, or if you choose to remain anonymous and don't care about more than 10 downloads per day, it
will make an anonymous call. 

The Quandl api offers additional arguments not yet implemented in this package. Included is a truncation argument called `rows`, which limits the data to that 
many observations, and a collapse argument called `period`, which offers "daily", "weekly", "monthly", "quarterly" and "annual" options. The order in which
data organized is hard-coded to ascending order (first row is the oldest), since percent change and other transformations depend on this ordering. If you want 
it the other way around, you can simply `flipud!(my_df)` the DataFrame.

Please file an issue if you have a feature request or think `kwargs` is a good fit for this package. The function currently operates on positional
arguments only. 

If you're using Julia 0.1
````julia
julia> using DataFrames
# warnings and an ugly error message, which can be ignored
julia> using Quandl
#warning message that the Calendar show method is over-written 
julia>
````
If you're using Julia 0.2
````julia
julia> using Quandl
#warning message that the Calendar show method is over-written 
julia>
````

The `quandl` method takes 3 positional arguments. The first argument is where you pass the Quandl code for the dataset you want
to download. The second argument is how many rows of data you'd like. The third argument is for collapsing the time interval to
a different time-frame. In our example below, the original data is daily, so adding the "monthly" argument coverts the daily data
to monthly data.

````julia

julia> quandl("YAHOO/INDEX_GSPC", 6, "monthly")
6x7 DataFrame:
                      Open    High     Low   Close    Volume Adjusted Close

[1,]    2012-11-30 1415.95 1418.86 1411.63 1416.18   3.966e9         1416.18
[2,]    2012-12-31 1402.43 1426.74 1398.11 1426.19 3.20433e9         1426.19
[3,]    2013-01-31 1501.96 1504.19 1496.76 1498.11 3.99988e9         1498.11
[4,]    2013-02-28 1515.99 1525.34 1514.46 1514.68 3.91232e9         1514.68
[5,]    2013-03-31 1562.86 1570.28 1561.08 1569.19 3.30444e9         1569.19
[6,]    2013-04-05 1559.98 1559.98  1539.5 1553.28 3.51541e9         1553.28


julia> quandl("GOOG/NASDAQ_AAPL", 6, "monthly")
6x6 DataFrame:
                     Open   High    Low  Close   Volume

[1,]    2012-11-30 586.79  588.4 582.68 585.28  1.3975e7
[2,]    2012-12-31 510.53  535.4  509.0 532.17 2.35533e7
[3,]    2013-01-31 456.98 459.28 454.98 455.49 1.14047e7
[4,]    2013-02-28 444.05 447.87  441.4  441.4 1.15184e7
[5,]    2013-03-31 449.82 451.82 441.62 442.66 1.58208e7
[6,]    2013-04-05  424.5 424.95 419.68  423.2 1.37034e7


````

If you're fine with the default settings of all rows and the time period of the original dataset, you can
simply pass one argument, the Quandl dataset code as a string.


````julia

julia> head(quandl("GALLUP/GUNS1"))
6x2 DataFrame:
                   % of Homes with Guns

[1,]    1960-12-31                  49.0
[2,]    1968-12-31                  50.0
[3,]    1972-12-31                  43.0
[4,]    1975-12-31                  44.0
[5,]    1978-12-31                  45.0
[6,]    1983-12-31                  40.0

````

