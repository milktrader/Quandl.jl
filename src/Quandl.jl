if VERSION < v"0.4-"
   using Dates, TimeSeries, DataFrames
else
   using Base.Dates, TimeSeries, DataFrames
end

module Quandl

if VERSION < v"0.4-"
   using Dates, TimeSeries, DataFrames, JSON, Requests
else
   using Base.Dates, TimeSeries, DataFrames, JSON, Requests
end

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
