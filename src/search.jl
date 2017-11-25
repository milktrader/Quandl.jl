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

function interactivequandl(query::AbstractString; page="1", results=20, order="des",
                           rows=100, frequency="daily", transformation="none", format="TimeArray",
                           auth_token="")

    # Get search results
    searches = quandlsearch(query, page = page, results = results, format="DataFrame", quiet=true)

    # Print results
    for i in 1:size(searches, 1)
        print_with_color(:yellow, string(i) * " ")
        print_with_color(:blue, string(searches[i, :Code]))
        print_with_color(:black, "   From " * string(searches[i, :From]) * " to " * string(searches[i, :To]) * "\n")
        print_with_color(:white, "    " * string(searches[i, :Name]) * "\n")
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
          return interactivequandl(query, page = string(parse(Int, page) + 1), results = results,
                                 format = format, auth_token = auth_token)
    else  # Get and return result
          #return quandl(searches[int(input), :Code],
        return quandl(searches[parse(Int, input), :Code],
                         order = order, rows = rows, frequency = frequency,
                       transformation = transformation, format = format,
                       api_key = auth_token)
    end
end