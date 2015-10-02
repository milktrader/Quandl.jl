function timearray(resp::Requests.Response)

    #This function transform the Response object into a TimeArray

    # Split the data on every "\n"
    data = split(Requests.text(resp), "\n")

    # Extract the head and body of the data
    head = data[1]  
    body = data[2:end]

    # Parse body    
    body[end] == "" ? pop!(body) : nothing # remove trailing empty string if it's there
    body      = [split(line, ",") for line in body] # split on comma

    ######### Timestamp
    # take the first row (assuming it's date)
    # TODO: regex query needed to catch edge cases
    dates     = [line[1] for line in body]
    timestamp = Date[Date(d) for d in dates] # parse dates

    ######### Values 
    svals = [line[2:end] for line in body] # get rows 2 to the end
    fvals = zeros(length(svals),length(svals[1]))
    
    for r in 1:size(fvals,1)
        for c in 1:size(fvals,2)
            if ~isempty(svals[r][c])
                fvals[r,c] = parse(Float64, svals[r][c])
            else
                fvals[r,c] = NaN
            end
        end
    end

    ######### Column names
    names = split(head, ",")[2:end] # Won't need the Date name (fist column) for TimeArray
    names = ASCIIString[name for name in names]

    return TimeArray(timestamp, fvals, names)
end
