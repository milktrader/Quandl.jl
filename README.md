## Julia API to Quandl 

[Quandl.com](http://www.quandl.com) is a lightweight interface to over 4 million open-source datasets. This package 
gives access to their api, and places the data in a time-aware DataFrame.

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

The `quandl` method takes 1 positional argument and currently supports two keyword arguments, `period` and 'rows`. The positional
argument is the Quandl code for the database you wish to download. 

````julia

julia> head(quandl("GALLUP/GUNS1"))
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   330  100   330    0     0   3018      0 --:--:-- --:--:-- --:--:--  3027
6x2 DataFrame:
              Year % of Homes with Guns
[1,]    1960-12-31                 49.0
[2,]    1968-12-31                 50.0
[3,]    1972-12-31                 43.0
[4,]    1975-12-31                 44.0
[5,]    1978-12-31                 45.0
[6,]    1983-12-31                 40.0

````
Using the `rows` kwarg.

````julia
julia> tail(quandl("GOOG/NASDAQ_TSLA", rows=1000))
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 37633  100 37633    0     0  92899      0 --:--:-- --:--:-- --:--:-- 92920
6x6 DataFrame:
              Date   Open   High    Low  Close    Volume
[1,]    2013-10-31 155.67 162.44  153.3 159.94 9.34046e6
[2,]    2013-11-01  163.0  165.9 160.41 162.17 7.18058e6
[3,]    2013-11-04  165.0 175.39 164.22  175.2 1.31204e7
[4,]    2013-11-05  180.0 181.43 171.36 176.81 2.24671e7
[5,]    2013-11-06 154.81 160.73 146.36 151.16 3.10717e7
[6,]    2013-11-07 144.19 145.65 137.62 139.77 2.22847e7
````
Using the `period` kwarg.

````julia
julia> head(quandl("YAHOO/INDEX_GSPC", period="monthly"))
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5097  100  5097    0     0   7313      0 --:--:-- --:--:-- --:--:--  7312
6x7 DataFrame:
              Date  Open  High   Low Close Volume Adjusted Close
[1,]    1950-01-31 16.82 16.82 16.82 16.82 1.25e6          16.82
[2,]    1950-02-28 17.28 17.28 17.28 17.28 1.71e6          17.28
[3,]    1950-03-31 17.56 17.56 17.56 17.56 1.57e6          17.56
[4,]    1950-04-30 17.96 17.96 17.96 17.96 2.19e6          17.96
[5,]    1950-05-31 18.67 18.67 18.67 18.67 1.33e6          18.67
[6,]    1950-06-30 19.14 19.14 19.14 19.14  1.7e6          19.14
````
