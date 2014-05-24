#function timearray(rq::Response)
function timearray(rq)

########### start dealing with SubStrings, which are confusing, hence the comments
head = split(rq.data, "\n")[1]
# "Date,Open,High,Low,Close,Volume"

body = split(rq.data, "\n")[2:end]
# remove trailing empty string if it's there
length(body[length(body)]) == 0 ? body = body[1:length(body)-1] : nothing

# split on comma
bd = [split(body[i], ",") for i in 1:length(body)]

######### timestamp
# take the first row (assuming it's date)
# TODO: regex query needed to catch edge cases
t = [bd[i][1] for i in 1:length(bd)]
# parse date 
tstamp = Date{ISOCalendar}[date(d) for d in t[1:length(t)]]

######### values 
# get rows 2 to the end
v = [bd[i][2:end] for i in 1:length(bd)]
# SubString{ASCIIString}["88.94","89.48","88.8","89.23","30617089.0"]
vals= ss2float(v)

####### colnames
snames = split(head,",")[2:end] # don't need the Date name for TimeArray
cnames = ASCIIString[s for s in snames]

TimeArray(tstamp, vals, cnames)
end
