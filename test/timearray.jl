using HDF5, JLD
include(Pkg.dir("Quandl/src/timearray.jl"))
include(Pkg.dir("Quandl/src/utilities.jl"))

ta_d = timearray(load(Pkg.dir("Quandl/test/response.jld"))["des_data"])
ta_a = timearray(load(Pkg.dir("Quandl/test/response.jld"))["asc_data"])

facts("timearray works on Request object") do

  context("there are three rows") do
      @fact  length(ta_d) => 3
      @fact  length(ta_a) => 3
  end

  context("oldest date first regardless of ordering argument") do
      @fact  ta_d[1].timestamp[1] < ta_d[3].timestamp[1] => true
      @fact  ta_a[1].timestamp[1] < ta_a[3].timestamp[1] => true
  end

  context("correct value at first row, first column") do
      @fact  ta_d[1][1].values[1] => 103.02
      @fact  ta_a[1][1].values[1] => 103.02
  end
end
