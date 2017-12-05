VERSION >= v"0.4.0-dev+6521" && __precompile__(true)

using Base.Dates, TimeSeries, DataFrames

module Quandl

using Base.Dates, TimeSeries, DataFrames, Requests, CSV

export quandlget,
       quandl,
       datatable,
       quandlsearch,
       set_auth_token,
       quandl_api_key,
       interactivequandl

include("config.jl")
include("error.jl")
include("api.jl")
include("timearray.jl")
include("dataframe.jl")
include("dataset.jl")
include("datatable.jl")
include("search.jl")


# Create empty auth token if none exists
if !isfile(joinpath(dirname(@__FILE__),"../token/auth_token"))
    # Create the token directory if needed
    if !ispath(joinpath(dirname(@__FILE__),"../token/"))
        mkdir(joinpath(dirname(@__FILE__),"../token/"))
    end
    # Write to the file
    open(joinpath(dirname(@__FILE__),"../token/auth_token"), "w") do token_file
        write(token_file, "")
    end
end

end
