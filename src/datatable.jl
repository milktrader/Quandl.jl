
function datatable(code::AbstractString; kwargs...)
    kwargs = Dict{Any, Any}(kwargs)
    resp = quandlapi("datatables/$code.csv", kwargs)
    df = CSV.read(IOBuffer(Requests.text(resp)))

    while haskey(resp.headers, "Cursor_ID")
        kwargs["qopts.cursor_id"] = resp.headers["Cursor_ID"]
        println(kwargs)
        resp = quandlapi("datatables/$code.csv", kwargs)
        df = [df; CSV.read(IOBuffer(Requests.text(resp)))]
    end
    
    return df
end
