df = dataframe(load(Pkg.dir("Quandl/test/response.jld"))["test_response"])

facts("dataframe works on Request object") do

  context("there are three rows") do
      @fact  size(df,1) => 3
  end

  context("there are six columns") do
      @fact  size(df,2) => 6
  end

  context("correct value at first row, first column") do
      @fact  df[1,2] => 103.02
  end

  context("oldest date first") do
      @fact df[1,1] < df[3,1] => true
  end
end
