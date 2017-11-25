
function quandldatatable(code::AbstractString; kwargs...)
    kwargs = Dict(kwargs)

    resp = quandlapi("datatables/$code.csv", kwargs)

    df = CSV.read(IOBuffer(Requests.text(resp)))
    
    while haskey(resp.headers, "Cursor_ID")
        kwargs["qopts.cursor_id"] = resp.headers["Cursor_ID"]
        resp = quandlapi("datatables/$code.csv", kwargs)
        df = rbind(df, CSV.read(IOBuffer(Requests.text(resp))))
    end
    
    return df
end