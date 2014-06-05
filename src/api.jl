function quandlget(id::String; order="des", rows=100, period="daily", transformation="none", format="TimeArray", auth_token="")
    
    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = {"sort_order" => order, "rows" => rows, "collapse" => period, "transformation" => transformation}

    # Open the auth_token file and add the token (if any) to the Query dictionary
    if auth_token == ""
        auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl"))
    end

    length(auth_token) < 50 && auth_token != "" ? query_args["auth_token"] = auth_token : nothing

    # Get the response from Quandl's API, using Query arguments (see Response.jl README)
    response = get("http://www.quandl.com/api/v1/datasets/$id.csv", query = query_args)

    if response.status != 200
        error("Dataset not found")
    end
    
    # Convert the response to the right DataType
    if format == "TimeArray"
        timearray(response) 
    elseif format == "DataFrame"
        dataframe(response)
    else
        error("Invalid $format format. If you want this format implemented, please report an issue or submit a pull request.")
    end
end

# alias quandl/quandlget
quandl = quandlget

function quandlsearch(query::ASCIIString; page="1", results="20", format="Dict")
        
    # Parsing query argument
    query = replace(query, " ", "+")

    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = {"query" => query, "page" => page, "per_page" => results}
          
    # Getting response from Quandl and parsing it
    response = get("http://www.quandl.com/api/v1/datasets.json", query = query_args)
    jsondict = JSON.parse(response.data)

    data = jsondict["docs"]
    totalcount = jsondict["total_count"]

    # Printing summary
    print("Returning $results results of $totalcount from page $page")

    # Convert the response to the right DataType
    if format == "Dict"
        return data
    elseif format == "DataFrame"
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
    else
        error("Invalid $format format. If you want this format implemented, please report an issue or submit a pull request.")
    end
end

function set_auth_token(token::String)

	# TODO: Verify if the token is valid
	token_file = open(Pkg.dir("Quandl/src/token/auth_token.jl"), "w")

	try
  		write(token_file, token * "\n") # Put a newline after the token
	finally
	    close(token_file)
	end

	return nothing
end
