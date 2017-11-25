function quandlget(id::AbstractString; order="des", rows=100, frequency="daily", transformation="none",
                   from="", to="", format="TimeArray", api_key="", silent=false)

    # verify and use API key

    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = Dict{Any,Any}("order" => order, "rows" => rows, "collapse" => frequency, "transform" => transformation)
    if api_key != ""
        query_args["api_key"] = api_key
    end
    # Ignore rows argument if start or end date range specified
    if from != ""
        delete!(query_args, "rows")
        query_args["start_date"] = from
    end
    if to != ""
        delete!(query_args, "rows")
        query_args["end_date"] = to
    end
    
    
    # Backward compatible
    try
        resp = quandlapi("datasets/$id.csv", query_args)
    catch err
        isa(err, QuandlApiError) || rethrow(err)
        println(" $(err.status): Error executing the request.")
        return Union{}
    end

    # Convert the response to the right DataType
    if format == "TimeArray"
        timearray(resp)
    elseif format == "DataFrame"
        dataframe(resp)
    else
        # return the raw fetch if requested format is not supported
        println("Currently only TimeArray and DataFrame formats are supported")
        resp
    end
end

# alias quandl/quandlget
quandl = quandlget

