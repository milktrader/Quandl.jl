using JLD, TimeSeries

include(joinpath(dirname(@__FILE__),"../src/timearray.jl"))

r  = load(joinpath(dirname(@__FILE__),"resp.jld"), "resp")
ta = timearray(r)["Close"]

facts("timearray works on Request object") do

  context("there are 30 rows") do
      @fact  length(ta) --> 30
  end

  context("correct values") do
      @fact  ta[1][1].values[1]  --> 115.01
      @fact  ta[30][1].values[1] --> 109.95
  end
end

facts("Request object inspection check") do
  
    context("status is 200") do
        @fact  r.status --> 200
    end
  
    context("data is UInt8") do
        @fact  r.data[1] --> 0x44
    end
 
# facts("floats and NaNs present") do
# 
#   context("NaN fills in missing values slot") do
# #      @pending isnan(sum(md.values[:,1])) --> true
#   end
# 
#   context("existing values remain floats") do
# #      @fact  sum(md.values[:,2]) --> 66.86
#   end
#end
end
