using TimeSeries

module Quandl

using TimeSeries

import Base.show

export quandl,
       @quandl # test macro

#################################
###### API ######################
#################################

function quandl(id::String)

  auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl")) 

  if length(auth_token) >  50
    qdata = download( "http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=asc&rows=$rows&collapse=$period", "q.csv")
  else
    qdata = download("http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=asc&rows=$rows&collapse=$period&auth_token=$auth_token", "q.csv")
  end

  qframe = readtime("q.csv")
  run(`rm q.csv`)
  
  return qframe
end
#################################
###### include ##################
##################################

#include("testquandl.jl")

end #module
