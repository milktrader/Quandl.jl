using DataFrames, Calendar, TimeSeries

module Quandl

using DataFrames, Calendar, TimeSeries

export quandl,
       @quandl # test macro

#################################
###### API ######################
#################################

function quandl(id::String)

  # code that takes quandl ida and fetches data into a time-aware DataFrame

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

include("testquandl.jl")

end #module
