## Julia API to Quandl 

Note: this package is not available yet on METADATA, so you'll need to `git clone` it into your `.julia` directory for the time-being. 

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


````julia
julia> using Quandl

#various warning messages that can be safely ingored including one that overwrites the Calendar show method

julia> head(quandl("GALLUP/GUNS1"))
6x2 DataFrame:
                   % of Homes with Guns

[1,]    1960-12-31                  49.0
[2,]    1968-12-31                  50.0
[3,]    1972-12-31                  43.0
[4,]    1975-12-31                  44.0
[5,]    1978-12-31                  45.0
[6,]    1983-12-31                  40.0

julia> quandl("YAHOO/INDEX_GSPC", 6, "monthly")
6x7 DataFrame:
                      Open    High     Low   Close    Volume Adjusted Close

[1,]    2012-11-30 1415.95 1418.86 1411.63 1416.18   3.966e9         1416.18
[2,]    2012-12-31 1402.43 1426.74 1398.11 1426.19 3.20433e9         1426.19
[3,]    2013-01-31 1501.96 1504.19 1496.76 1498.11 3.99988e9         1498.11
[4,]    2013-02-28 1515.99 1525.34 1514.46 1514.68 3.91232e9         1514.68
[5,]    2013-03-31 1562.86 1570.28 1561.08 1569.19 3.30444e9         1569.19
[6,]    2013-04-05 1559.98 1559.98  1539.5 1553.28 3.51541e9         1553.28
````

The default setting for the `quandl` function is 1 million rows and the default period. 
