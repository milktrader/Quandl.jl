facts("auth_token file exists") do

  context("auth_token is stubbed with message") do
      @fact length(readdlm(Pkg.dir("Quandl/src/token/auth_token.jl"))) => 28
  end
end
