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



````

