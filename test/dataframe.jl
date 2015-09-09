## awaiting to to implement JLD-based testing

# upfront apologies for this ... 
facts("awaiting JLD implementation for tests") do
    context("things will work out fine") do
        @fact true => 1
    end
end

# using Dates, DataFrames, HDF5, JLD, Requests
# 
# include(Pkg.dir("Quandl/src/dataframe.jl"))
# 
# dfa = dataframe(load(Pkg.dir("Quandl/test/response.jld"))["asc"])
# dfd = dataframe(load(Pkg.dir("Quandl/test/response.jld"))["des"])
# 
# facts("dataframe works on Request object") do
# 
#   context("there are three rows") do
#       @fact  size(dfa,1) => 3
#       @fact  size(dfd,1) => 3
#   end
# 
#   context("there are six columns") do
#       @fact  size(dfa,2) => 6
#       @fact  size(dfd,2) => 6
#   end
# 
#   context("correct value at first row, first column, depending on ordering") do
#       @fact  dfa[1,2] => 103.02
#       @fact  dfd[1,2] => 104.08
#   end
# 
#   context("oldest date last when ascending") do
#       @fact dfa[1,1] < dfa[3,1] => true
#   end
# 
#   context("oldest date first when descending") do
#       @fact dfd[1,1] > dfd[3,1] => true
#   end
# end
