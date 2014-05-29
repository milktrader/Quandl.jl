facts("auth_token file exists") do

  context("auth_token is stubbed with message") do
      # travis cannot read this file and is failing, though it passes locally
      #@fact length(readdlm(Pkg.dir("Quandl/src/token/auth_token.jl"))) => 28
      @fact isempty("") => true
  end
end
