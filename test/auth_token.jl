facts("Auth token generation is successfull")  do
    include(Pkg.dir("Quandl/src/Quandl.jl"))

    facts("created an empty token file after importing module") do
        facts("created token file") do
            @fact isfile(Pkg.dir("Quandl/token/auth_token")) => true
        end

        facts("token file is empty") do
            @fact open(readall, Pkg.dir("Quandl/token/auth_token")) => ""
        end
    end

    facts("invalid tokens detected") do
        facts("detects short token") do
            @fact_throws Quandl.set_auth_token("a")
        end

        facts("detects long token") do
            @fact_throws Quandl.set_auth_token("a"^21)
        end
    end
end
