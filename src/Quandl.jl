using DataFrames, Calendar

module Quandl

using DataFrames, Calendar

import Base.show

export quandl,
       @quandl # test macro

#################################
###### API ######################
#################################

function quandl(id::String, rows::Int, period::String)

  auth_token = open(readall, Pkg.dir("Quandl/src/token/auth_token.jl")) 
 
#   period=="d"?period="daily":
#   period=="w"?period="weekly":
#   period=="m"?period="monthly":
#   period=="q"?period="quarterly":
#   period=="a"?period="annual":period

  if length(auth_token) >  50
    qdata = readlines(`curl -s "http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=asc&rows=$rows&collapse=$period"`)
  else
    qdata = readlines(`curl -s "http://www.quandl.com/api/v1/datasets/$id.csv?sort_order=asc&rows=$rows&collapse=$period&auth_token=$auth_token"`)
  end

  name_string = qdata[1]
  val_string = qdata[2:end]

  if length(val_string) < 1
    error("you've probably exceeded your daily limit:\n 10 without token, 100 with a auth token")
  end

  na  = split(name_string, ",")'
  va  = split(val_string[1], ",")'

  for i in 2:length(val_string)         
    va  = [va ; split(val_string[i], ",")']
  end

  time_array = parse_date("yyyy-MM-dd", va[:,1])

  df = @DataFrame("" => time_array)

  for i in 2:length(na)
    colname  = na[i]
    within!(df, :($colname = float($va[:,$i])))
  end

#  # correct the order if the DataFrame has more than 1 row 
#  #if ~isempty(df[""][2]
#  if nrow(df) > 1
#    if df[""][1] > df[""][2]
#      flipud!(df)
#    end
#  end

   df[""] = IndexedVector(df[""])
  df
end

quandl(id::String) = quanld(id::String, 100000, "")

#################################
###### show #####################
#################################

function show(io::IO, t::CalendarTime)
  s = format("yyyy-MM-dd", t)
  print(io, s)
end

#################################
###### include ##################
##################################

#include("testquandl.jl")

end #module
