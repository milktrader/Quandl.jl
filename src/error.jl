type QuandlApiError <: Exception
    var::String
    status::Int64
end
Base.showerror(io::IO, e::QuandlApiError) = print(io, e.var)