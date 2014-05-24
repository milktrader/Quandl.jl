function quandl(id::String; rows=100, period="daily", format="TimeArray")

    auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl")) 
  
    if length(auth_token) >  50 
        rq = get( "http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=des&rows=$rows&collapse=$period") 
    else
        rq = get("http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=des&rows=$rows&collapse=$period&auth_token=$auth_token")
    end
  
    if format == "TimeArray"
        timearray(rq) 
    elseif format == "DataFrame" 
        print_with_color(:yellow, "DataFrame format not supported yet - please submit a PR") 
        println("")
    else
        print_with_color(:yellow, "wat? If you want this format, please submit a PR. :-)")
        println("")
    end
 
end
