function timearray(response::Requests.Response)
    #This function transform the Response object on a TimeArray

    # Split the data on every "\n"
    data = split(response.data, "\n")

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
    timestamp = Date{ISOCalendar}[date(d) for d in dates] # parse dates

    ######### Values 
    vals = [line[2:end] for line in body] # get rows 2 to the end
    vals = ss2float(vals) # SubString{ASCIIString}["88.94","89.48","88.8","89.23","30617089.0"]

    ######### Column names
    names = split(head, ",")[2:end] # Won't need the Date name (fist column) for TimeArray
    names = ASCIIString[name for name in names]

    return TimeArray(timestamp, vals, names)
end
