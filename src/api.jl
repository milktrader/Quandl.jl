
quandlbaseurl() = "https://www.quandl.com/api/v3"

function quandlapi(path, params::Dict)
    
    package_version = string(Pkg.installed("Quandl"))
    headers = Dict("Request-Source" => "julia", "Request-Source-Version" => package_version)
    if length(Quandl.api_key()) > 0
        headers["X-Api-Token"] = Quandl.api_key()
    end
    # query param api_key takes precedence
    if haskey(params, "api_key")
      headers["X-Api-Token"] = params["api_key"]
      delete!(params, "api_key")
    end
    
    
    # Parameters require extra formatting for datatable api
    formatted_params = formatrequestparams(params)
    url = "$(quandlbaseurl())/$(path)"

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
   outparams = Dict() 
   for (k, v) in params
        if isa(v, Dict)
            for(k1, v1) in v
                if isa(v1, Array)
                    outparams["$k.$k1"] = join(v1, ",")
                else
                    outparams["$k.$k1"] = v1
                end
            end
        elseif isa(v, Array)
            outparams[k] = join(v, ",")
        else
            outparams[k] = v
        end
    end
    return outparams
end

