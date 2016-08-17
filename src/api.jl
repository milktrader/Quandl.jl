function quandlget(id::AbstractString; order="des", rows=100, frequency="daily", transformation="none",
                   from="", to="", format="TimeArray", api_key="")

    # verify and use API key
    if api_key==""
        if !ispath(joinpath(dirname(@__FILE__),"../token/"))
            println("Note: for unlimited access, you may need to get an API key at quandl.com")
        else
            api_key=readall(joinpath(dirname(@__FILE__),"../token/auth_token"))
            if api_key==""
                println("Note: for unlimited access, you may need to get an API key at quandl.com")
            else
                println("Using API key: ", api_key)
            end
        end
    end

    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = Dict{Any,Any}("order" => order, "rows" => rows, "collapse" => frequency, "transform" => transformation, "api_key" => api_key)

    # Ignore rows argument if start or end date range specified
    if from != ""
        delete!(query_args, "rows")
        query_args["start_date"] = from
    end

    if to != ""
        delete!(query_args, "rows")
        query_args["end_date"] = to
    end

    # Get the response from Quandl's API, using Query arguments (see Response.jl README)
    resp = get("https://www.quandl.com/api/v3/datasets/$id.csv", query = query_args)

    # return Union{} in case of fetch error
    if resp.status != 200
        println(" $(resp.status): Error executing the request.")
        Union{}
    else
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
end

# alias quandl/quandlget
quandl = quandlget

function quandlsearch(query::AbstractString; page=1, results=20, format="DataFrame", quiet=false)

    query = replace(query, " ", "+")

    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = Dict{Any,Any}("query" => query, "page" => page, "per_page" => results)

    # Getting response from Quandl and parsing it
    resp       = get("https://www.quandl.com/api/v1/datasets.json", query = query_args)
    jsondict   = Requests.json(resp)
    data       = jsondict["docs"]
    totalcount = jsondict["total_count"]

    # Printing summary
    if !quiet
        println("Returning $results results of $totalcount from page $page")
    end

    # Convert the response to the right DataType
    if format == "DataFrame"
        # Create an NA 1x5 DataFrame
        df = convert(DataFrame, ["" "" "" "" ""])

        # Constructiong the DataFrame
        for elem in data
            newline = convert(DataFrame, ["$(elem["source_code"])/$(elem["code"])" "$(elem["name"])" "$(elem["frequency"])" "$(elem["from_date"])" "$(elem["to_date"])"])
            df = vcat(df,newline)
        end

        # Naming the columns
        names!(df, [:Code, :Name, :Frequency, :From, :To])

        # Not returning the NA line
        return df[2:end,:]
    elseif format == "Dict"
        return data
    else
        error("Invalid $format format. Currently only DataFrame and Dict are supported. If you want this format implemented, please file an issue or submit a pull request.")
    end
end

function interactivequandl(query::AbstractString; page="1", results="20", order="des",
                           rows=100, frequency="daily", transformation="none", format="TimeArray",
                           auth_token="")

	# Get search results
    searches = quandlsearch(query, page = page, results = results, format="DataFrame", quiet=true)

    # Print results
    for i in 1:size(searchres, 1)
       	print_with_color(:yellow, string(i) * " ")
       	print_with_color(:blue, string(searchres[i, :Code]))
       	print_with_color(:black, "   From " * string(searchres[i, :From]) * " to " * string(searchres[i, :To]) * "\n")
       	print_with_color(:white, "    " * string(searchres[i, :Name]) * "\n")
    end

    # Print prompt
    print_with_color(:yellow, "\n==> ")
    print_with_color(:white, "Enter n° of the dataset to be downloaded | (N)ext page | (Q)uit\n")
    println("-------------------------------------------------------------------")
    print_with_color(:yellow, "==> ")

    # Receive input from user
    input = readline()[1:end-1] # Remove \n from end

    # Return desired output
    if input == "q" || input == "Q" || input == "" # Quit
       	return nothing
    elseif input == "n" || input == "N" # Next page
    	  return interactivequandl(query, page = string(int(page) + 1), results = results,
                                 format = format, auth_token = auth_token)
    else  # Get and return result
	      return quandl(searchres[int(input), :Code],
	                     order = order, rows = rows, frequency = frequency,
                       transformation = transformation, format = format,
                       auth_token = auth_token)
    end
end

function set_auth_token(token::AbstractString)

    # Check the validity of the token
    if length(token) != 20 && length(token) != 0
        error("Invalid Token: must be 20 characters long or be an empty string")
    end

    # Create the token directory if needed
    if !ispath(joinpath(dirname(@__FILE__),"../token/"))
        mkdir(joinpath(dirname(@__FILE__),"../token/"))
    end

    # Write to the file
    open(joinpath(dirname(@__FILE__),"../token/auth_token"), "w") do token_file
        write(token_file, token)
    end

	  return nothing
end
