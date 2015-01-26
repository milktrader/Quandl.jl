using TimeSeries, HDF5, JLD, Requests

include(Pkg.dir("Quandl/src/timearray.jl"))

md  = timearray(load(Pkg.dir("Quandl/test/response.jld"))["missing"])
taa = timearray(load(Pkg.dir("Quandl/test/response.jld"))["asc"])
tad = timearray(load(Pkg.dir("Quandl/test/response.jld"))["des"])

facts("timearray works on Request object") do

  context("there are three rows") do
      @fact  length(taa) => 3
      @fact  length(tad) => 3
  end

  context("oldest date first regardless of ordering argument") do
      @fact  taa[1].timestamp[1] < taa[3].timestamp[1] => true
      @fact  tad[1].timestamp[1] < tad[3].timestamp[1] => true
  end

  context("correct value at first row, first column, regardless of ordering argument") do
      @fact  taa[1][1].values[1] => 103.02
      @fact  tad[1][1].values[1] => 103.02
  end
end
 
facts("floats and NaNs present") do

  context("NaN fills in missing values slot") do
      @fact  isnan(sum(md.values[:,1])) => true
  end

  context("existing values remain floats") do
      @fact  sum(md.values[:,2]) => 66.86
  end
end
