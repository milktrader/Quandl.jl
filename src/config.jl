# Backwards compatible
function set_auth_token(token::AbstractString)

    # Check the validity of the token
    if length(token) != 20 && length(token) != 0
        error("Invalid Token: must be 20 characters long or be an empty string")
    end

    quandl_api_key(token)

    return nothing
end

global qapi_key = ""
function quandl_api_key(api_key::AbstractString="")
    global qapi_key
    # New key to assign
    if length(api_key) > 0
        qapi_key = api_key

        # Create the token directory if needed
        if !ispath(joinpath(dirname(@__FILE__),"../token/"))
            mkdir(joinpath(dirname(@__FILE__),"../token/"))
        end

        # Write to the file
        open(joinpath(dirname(@__FILE__),"../token/auth_token"), "w") do token_file
            write(token_file, token)
        end
    end
    # if nothing assigned check for old key
    if length(qapi_key) == 0
        qapi_key=readstring(joinpath(dirname(@__FILE__),"../token/auth_token"))
    end
    return qapi_key
end