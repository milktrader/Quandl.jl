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

  sa  = split(val_string[1], ",")'
  for i in 2:length(val_string)         
    sa  = [sa ; split(val_string[i], ",")']
  end
  
  time_array = Calendar.parse("yyyy-MM-dd", sa[:,1])
 
  df = DataFrame(quote       
                  Date = $time_array
                  Value = float($sa[:,2])
                  end)
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
