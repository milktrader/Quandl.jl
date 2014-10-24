ta = timearray(load(Pkg.dir("Quandl/test/response.jld"))["test_response"])

facts("timearray works on Request object") do

  context("there are three rows") do
      @fact  length(ta) => 3
  end

  context("correct value at first row, first column") do
      @fact  ta[1][1].values[1] => 103.02
  end

  context("oldest date first") do
      @fact  ta[1].timestamp[1] < ta[3].timestamp[1] => true
  end
end
