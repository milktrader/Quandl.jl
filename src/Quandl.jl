using TimeSeries

module Quandl

using TimeSeries

export quandl

###### API ######################

function quandl(id::String; rows=100, period="daily")

  auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl")) 

  if length(auth_token) >  50
    qdata = download( "http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=dec&rows=$rows&collapse=$period", "q.csv")
  else
    qdata = download("http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=dec&rows=$rows&collapse=$period&auth_token=$auth_token", "q.csv")
  end

  qarray = readtimearray("q.csv")

  run(`rm q.csv`)
  
  return qarray
end

end #module
