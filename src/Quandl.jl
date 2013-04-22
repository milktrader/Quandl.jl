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

# eliminate rows that have a date but no prices (market closed on a holiday)
  va_valid = String[]
  for i in 1:length(val_string)
    if length(val_string[i]) > 20
    push!(va_valid, val_string[i])
    end
  end

  #if length(val_string) < 1
  if length(va_valid) < 1
    error("you've probably exceeded your daily limit:\n 10 without token, 100 with a auth token")
  end

  na  = split(name_string, ",")'
  va  = split(va_valid[1], ",")'
  
  for i in 2:length(va_valid)         
    va  = [va ; split(va_valid[i], ",")']
  end

#  time_array = parse_date("yyyy-MM-dd", va[:,1]) # method not defined in master METADATA
  time_array = Calendar.parse("yyyy-MM-dd", va[:,1])

  df = @DataFrame("Date" => time_array)

  for i in 2:length(na)
    colname  = na[i]
    within!(df, :($colname = float($va[:,$i])))
  end

#  # correct the order if the DataFrame has more than 1 row 
#  #if ~isempty(df[""][2]
#  if nrow(df) > 1
#    if df["Date"][1] > df["Date"][2]
#      flipud!(df)
#    end
#  end

   df["Date"] = IndexedVector(df["Date"]) # uncomment for Julia 0.2
  df
end

#quandl(id) = quandl(id::String, 100000, "") # trouble passing too many rows into GOOG

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
