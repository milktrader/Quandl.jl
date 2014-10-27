using TimeSeries, HDF5, JLD, Requests

include(Pkg.dir("Quandl/src/timearray.jl"))
include(Pkg.dir("Quandl/src/utilities.jl"))

md = timearray(load(Pkg.dir("Quandl/test/response.jld"))["missing"])

facts("ss2float") do

  context("NaN fills in missing values slot") do
      @fact  isnan(sum(md.values[:,1])) => true
  end

  context("existing values remain floats") do
      @fact  sum(md.values[:,2]) => 66.86
  end
end
