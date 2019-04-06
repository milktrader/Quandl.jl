function dataframe(resp::HTTP.Response)

    df = CSV.read(IOBuffer(Requests.text(resp)))

    # force oldest date to first row

    if issorted(df[:Date])
        return df
    else
        return sort!(df)
    end
end
