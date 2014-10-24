using HDF5, JLD
include(Pkg.dir("Quandl/src/timearray.jl"))
include(Pkg.dir("Quandl/src/utilities.jl"))

ta = timearray(load(Pkg.dir("Quandl/test/response.jld"))["test_response_with_missing"])

facts("ss2float") do

  context("parses as expected") do
      @fact isempty("") => true
  end
end
