function dataframe(response::Requests.Response)

    buffer = PipeBuffer() # open a buffer in which to dump data
    df     = DataFrame()  # init empty DataFrame

    try
        # Write the data to the buffer
        write(buffer, Requests.text(response))

        # Use DataFrame's readtable to read the data directly from buffer
        df = readtable(buffer)
        
        # Convert dates to Dates object
        df[:Date] = Date[Date(d) for d in df[:Date]]

    finally
        close(buffer)   
    end

    return df
end
