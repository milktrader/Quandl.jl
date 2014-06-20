module Quandl

using JSON, Requests, Reexport, Dates
@reexport using TimeSeries, DataFrames

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
