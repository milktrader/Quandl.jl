function quandl(id::String; order="des", rows=100, period="daily", transformation="none", format="TimeArray", auth_token="")
    
    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = {"sort_order" => order, "rows" => rows, "collapse" => period, "transformation" => transformation}

    # Open the auth_token file and add the token (if any) to the Query dictionary
    if auth_token == ""
        auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl"))
    end

    length(auth_token) > 50 || auth_token != "" ? query_args["auth_token"] = auth_token : nothing

    # Get the response from Quandl's API, using Query arguments (see Response.jl README)
    response = get("http://www.quandl.com/api/v1/datasets/$id.csv", query = query_args) 
    
    # Convert the response to the right DataType
    if format == "TimeArray"
        timearray(response) 
    elseif format == "DataFrame" 
        dataframe(response)
    else
        error("Invalid $format format. If you want this format implemented, please report an issue or submit a pull request.")
    end
end
