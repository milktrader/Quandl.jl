function dataframe(resp::Requests.Response)

    buffer = PipeBuffer() # open a buffer in which to dump data
    df     = DataFrame()  # init empty DataFrame

    try
        # Write the data to the buffer
        write(buffer, Requests.text(resp))

        # Use DataFrame's readtable to read the data directly from buffer
        df = readtable(buffer)
        
        # Convert dates to Dates object
        df[:Date] = Date[Date(d) for d in df[:Date]]

    finally
        close(buffer)   
    end

    # force oldest date to first row

    if issorted(df[:Date])
        return df
    else
        return sort!(df)
    end
end
