using TimeSeries

module Quandl

using TimeSeries

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

  header = qdata[1]
  vals   = qdata[2:end]

#### eliminate rows that have a date but no prices (market closed on a holiday)
#### this shouldn't be necessary once readtable accepts http, and will be 
#### better since NAs can be filled in. 
###  va_valid = String[]
###  for i in 1:length(val_string)
###    #if length(val_string[i]) > 20 # FRED DGS10 is length 16
###    if length(val_string[i]) > 15
###    push!(va_valid, val_string[i])
###    end
###  end

### need better catch
###  #if length(val_string) < 1
###  if length(va_valid) < 1
###    error("you've probably exceeded your daily limit:\n 10 without token, 100 with a auth token")
###  end

  h  = split(header, ",")'
  v  = split(vals[1], ",")'
  
###  for i in 2:length(va_valid)         
###    va  = [va ; split(va_valid[i], ",")']
###  end

  vv = [split(vals[i], ",") for i=1:size(vals)[1]]

####  time_array = parse_date("yyyy-MM-dd", va[:,1]) # method not defined in master METADATA
###  time_array = Calendar.parse("yyyy-MM-dd", va[:,1])
###
###  df = @DataFrame("Date" => time_array)

############## function readtime(filename::String) # Datetime version
##############   df         = readtable(filename)
##############   df["Date"] = Date[date(d) for d in df["Date"]]
##############   df["Date"] = IndexedVector(df["Date"])
##############   df[1,"Date"] > df[2, "Date"]?  flipud!(df): df
##############   return df
############## end
  df = DataFrame("Date" = parse_date("yyyy-MM-dd", vv))

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

   df["Date"] = IndexedVector(df["Date"]) 
  return df
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
