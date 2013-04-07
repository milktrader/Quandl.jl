## Julia API to Quandl 

Note: this package is not available yet on METADATA, so you'll need to `git clone` it into your `.julia` directory for the time-being. 

````julia
julia> using Quandl

#various warning messages that can be safely ingored including one that overwrites the Calendar show method

julia> quandl("GALLUP/GUNS1")
19x2 DataFrame:
               Date Value
[1,]     1960-12-31  49.0
[2,]     1968-12-31  50.0
[3,]     1972-12-31  43.0
[4,]     1975-12-31  44.0
[5,]     1978-12-31  45.0
[6,]     1983-12-31  40.0
[7,]     1989-12-31  47.0
[8,]     1991-12-31  48.0
[9,]     1994-12-31  51.0
[10,]    1996-12-31  38.0
[11,]    1997-12-31  42.0
[12,]    1999-12-31  34.0
[13,]    2000-12-31  42.0
[14,]    2003-12-31  40.0
[15,]    2004-12-31  43.0
[16,]    2005-12-31  38.0
[17,]    2006-12-31  43.0
[18,]    2010-12-31  39.0
[19,]    2012-12-31  45.0
````

