function quandlget(id::String; order="des", rows=100, frequency="daily", transformation="none", start_date="", end_date="", format="TimeArray", auth_token="")
    
    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = {"sort_order" => order, "rows" => rows, "collapse" => frequency, "transformation" => transformation, "trim_start" => start_date, "trim_end" => end_date}

    # Open the auth_token file and add the token (if any) to the Query dictionary
    if auth_token == ""
        auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl"))
    end

    # Do not use rows if start or end date range specified
    if start_date != "" || end_date != ""
        delete!(query_args, "rows")
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

function quandlsearch(query::ASCIIString; page=1, results=20, format="DataFrame", quiet=false)
           
    query = replace(query, " ", "+")

    # Create a dictionary with the Query arguments that we pass to get() function
    query_args = {"query" => query, "page" => page, "per_page" => results}
          
    # Getting response from Quandl and parsing it
    response = get("http://www.quandl.com/api/v1/datasets.json", query = query_args)
    jsondict = JSON.parse(response.data)

    data = jsondict["docs"]
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
        error("Invalid $format format. Currently only DataFrame and Dict are supported. If you want this format implemented, please report an issue or submit a pull request.")
    end
end

function interactivequandl(query::ASCIIString; page="1", results="20", order="des", rows=100, frequency="daily", transformation="none", format="TimeArray", auth_token="")

	# Get search results
    searchres = quandlsearch(query, page = page, results = results, format="DataFrame", quiet=true)

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
    	return interactivequandl(query, page = string(int(page) + 1), results = results, format = format, auth_token = auth_token)
    else  # Get and return result
	    return quandl(searchres[int(input), :Code], 
	        order = order, rows = rows, frequency = frequency, transformation = transformation, format = format, auth_token = auth_token)
	end
end

function set_auth_token(token::String)

	# TODO: Verify if the token is valid
	token_file = open(Pkg.dir("Quandl/src/token/auth_token.jl"), "w")

	try
  		write(token_file, token)
	finally
	    close(token_file)
	end

	return nothing
end
