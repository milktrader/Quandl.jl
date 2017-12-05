# Backwards compatible
function set_auth_token(token::AbstractString)

    # Check the validity of the token
    if length(token) != 20 && length(token) != 0
        error("Invalid Token: must be 20 characters long or be an empty string")
    end

    Quandl.api_key(token)

    return nothing
end

global qapi_key = ""
function api_key(api_key::AbstractString="")
    global qapi_key
    # New key to assign
    if length(api_key) > 0
        qapi_key = api_key

        # Write to the file
        open(joinpath(dirname(@__FILE__),"../token/auth_token"), "w") do token_file
            write(token_file, api_key)
        end
    end
    # if nothing assigned check for old key
    if length(qapi_key) == 0
        qapi_key=readstring(joinpath(dirname(@__FILE__),"../token/auth_token"))
    end
    return qapi_key
end
