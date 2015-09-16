facts("Auth token generation is successful")  do
    include(Pkg.dir("Quandl/src/Quandl.jl"))

    context("created an empty token file after importing module") do
        context("created token file") do
            @fact isfile(Pkg.dir("Quandl/token/auth_token")) --> true
        end

        context("token file is empty") do
            @fact open(readall, Pkg.dir("Quandl/token/auth_token")) --> ""
        end
    end

    context("invalid tokens detected") do
        context("detects short token") do
            @fact_throws Quandl.set_auth_token("a")
        end

        context("detects long token") do
            @fact_throws Quandl.set_auth_token("a"^21)
        end
    end
end
