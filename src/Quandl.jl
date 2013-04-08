using DataFrames, Calendar, TimeSeries

module Quandl

using DataFrames, Calendar, TimeSeries

import Base.show

export quandl,
       @quandl # test macro

#################################
###### API ######################
#################################

function quandl(id::String)
  qdata = readlines(`curl -s "http://www.quandl.com/api/v1/datasets/$id.csv"`)

  name_string = qdata[1]
  val_string = qdata[2:end]

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

  df[""] = IndexedVector(df[""])

  flipud(df)
end

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
