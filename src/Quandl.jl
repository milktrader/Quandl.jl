using Dates, TimeSeries, DataFrames

module Quandl

using Dates, TimeSeries, DataFrames, HTTP, JSON, CSV

export quandlget,
       quandl,
       quandlsearch,
       set_auth_token,
       interactivequandl

include("api.jl")
include("timearray.jl")
include("dataframe.jl")

# Create empty auth token if none exists
if !isfile(joinpath(dirname(@__FILE__),"../token/auth_token"))
    set_auth_token("")
end

end
