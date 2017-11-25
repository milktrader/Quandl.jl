VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

using Base.Dates, TimeSeries, DataFrames

module Quandl

using Base.Dates, TimeSeries, DataFrames, Requests, CSV

export quandlget,
       quandl,
       quandldatatable,
       quandlsearch,
       set_auth_token,
       quandl_api_key,
       interactivequandl

include("config.jl")
include("error.jl")
include("api.jl")
include("timearray.jl")
include("dataframe.jl")
include("datasets.jl")
include("datatables.jl")
include("search.jl")


# Create empty auth token if none exists
if !isfile(joinpath(dirname(@__FILE__),"../token/auth_token"))
    set_auth_token("")
end

end
