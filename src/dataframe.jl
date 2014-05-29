# function dataframe(rq::Response)

function dataframe(rq)

	buff = PipeBuffer()  # open a buffer in which to dump data
	df = DataFrame() # init empty DataFrame

	try
		# get data from rq and split into an array
		data = rq.data
		data = chomp(data)
		data = split(data, "\n");
		
		# write each line to the PipeBuffer
		for i = 1:length(data)
	    	write(buff, data[i], "\n")
		end	

		# use DataFrame's readtable to read the data directly from buffer
		df = readtable(buff)
		
		# convert date to DateTime object
		df[:Date] = Date{ISOCalendar}[date(d) for d in df[:, 1]]

	finally
		close(buff)
	end

	df

end
