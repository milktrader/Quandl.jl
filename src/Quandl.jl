using Base.Dates, TimeSeries, DataFrames

module Quandl

using Base.Dates, TimeSeries, DataFrames, Requests

export quandlget,
       quandl,
       quandlsearch,
       set_auth_token,
       interactivequandl

include("api.jl")
include("timearray.jl")
include("dataframe.jl")

# Create empty auth token if none exists
if !isfile(Pkg.dir("Quandl/token/auth_token"))
    set_auth_token("")
end

end
