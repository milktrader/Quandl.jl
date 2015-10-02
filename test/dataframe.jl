using JLD, DataFrames 
 
include(Pkg.dir("Quandl/src/dataframe.jl"))
 
r  = load(Pkg.dir("Quandl/test/resp.jld"), "resp")
df = dataframe(r)

facts("dataframe works on Request object") do

  context("there are three rows") do
      @fact  size(df,1) --> 30
      @fact  size(df,1) --> 30
  end

  context("there are six columns") do
      @fact  size(df,2) --> 13
      @fact  size(df,2) --> 13
  end

  context("correct values") do
      @fact  df[:Close][1]  --> 115.01
      @fact  df[:Close][30] --> 109.95
  end

  context("oldest date last") do
      @fact df[1,1] < df[30,1] --> true
  end
end
