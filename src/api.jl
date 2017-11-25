
quandlbaseurl() = "https://www.quandl.com/api/v3"

function quandlapi(path, params::Dict)
    
    package_version = string(Pkg.version("Quandl"))
    headers = Dict("Request-Source" => "julia", "Request-Source-Version" => package_version)
    if length(Quandl.api_key())
        headers["X-Api-Token"] = Quandl.api_key()
    end
    # query param api_key takes precedence
    if haskey(params, "api_key")
      headers["X-Api-Token"] = params["api_key"]
      delete!(params, "api_key")
    end
    
    
    # Parameters require extra formatting for datatable api
    formatted_params = formatrequestparams(params)
    url = "$(quandlbaseurl())/$(path).csv"

    # Get the response from Quandl's API, using Query arguments (see Response.jl README)
    resp = get(url, query = formatted_params, headers = headers)

    if resp.status != 200
        throw(QuandlApiError(Requests.text(resp), resp.status))
    end
    resp
end

# This formats Dict("qopts" => Dict("columns" => ["ticker", "date", "close"]))
# as Dict("qopts.columns" => ["ticker", "date", "close"])
function formatrequestparams(params::Dict)
    for (n, f) in enumerate(params)
        if isa(f, Dict)
            for(n1, f1) in enumerate(f)
                params["$n.$n1"] = f1
            end
        end
        delete!(params, n)
    end
    return params
end

