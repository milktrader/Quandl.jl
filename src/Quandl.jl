module Quandl

using Dates, TimeSeries, DataFrames, JSON, Requests, Reexport 
@reexport using Dates,TimeSeries, DataFrames

export quandlget, 
       quandl, 
       quandlsearch, 
       set_auth_token,
       interactivequandl

include("api.jl")
include("timearray.jl")
include("utilities.jl")
include("dataframe.jl")

end
