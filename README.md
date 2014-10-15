[![Build Status](https://travis-ci.org/milktrader/Quandl.jl.png)](https://travis-ci.org/milktrader/Quandl.jl)
[![Package Evaluator](http://iainnz.github.io/packages.julialang.org/badges/Quandl_0.3.svg)](http://iainnz.github.io/packages.julialang.org/?pkg=Quandl&ver=0.3)

## Julia API to Quandl 

[Quandl.com](http://www.quandl.com) is a lightweight interface to over nine million open-source datasets. This package creates an easy interface to obtain and manipulate these datasets, using TimeArrays or DataFrames, as well as letting the user search for data.

````julia
Pkg.add("Quandl")
````

## Getting data

The `quandl` (or `quandlget`) function takes one positional argument (the Quandl code for the database you wish to download) and currently supports six keyword arguments:

- `order`, which is the order in which the returned Dataset is sorted (default is `des`);
- `rows`, which is the number of rows that the returned Dataset will have (default is `100`);
- `frequency`, which is the frequency desired for the Dataset (default is `daily`);
- `transformation`, which is the calculation Quandl do to to Dataset prior to download (default is `none`);
- `auth_key`, which is user's API key (see the next section for further information);
- `format`, which is the type returned by the function (default is `"TimeArray"`, but you can use `"DataFrame"` also).

````julia
julia> quandl("GOOG/NASDAQ_QQQ") 
100x5 TimeArray{Float64,2} 2013-12-31 to 2014-05-23

             Open   High   Low    Close  Volume
2013-12-31 | 87.54  87.96  87.52  87.96  2.4896065e7
2014-01-02 | 87.55  87.58  87.02  87.27  2.9190009e7
2014-01-03 | 87.27  87.35  86.62  86.64  3.5727317e7
2014-01-06 | 86.65  86.76  86.0   86.32  3.2092437e7
⋮
2014-05-20 | 88.28  88.6   87.64  88.0   3.3715953e7
2014-05-21 | 88.16  88.89  88.11  88.84  3.6837678e7
2014-05-22 | 88.94  89.48  88.8   89.23  3.0617089e7
2014-05-23 | 89.33  89.9   89.12  89.88  2.2691254e7
````

You can also dowload your data into a DataFrame.

```julia
julia> quandl("GOOG/NASDAQ_QQQ", format="DataFrame")
100x6 DataFrame
|-------|------------|-------|-------|-------|-------|-----------|
| Row   | Date       | Open  | High  | Low   | Close | Volume    |
| 1     | 2014-05-30 | 91.33 | 91.45 | 90.83 | 91.31 | 2.99169e7 |
| 2     | 2014-05-29 | 91.05 | 91.31 | 90.86 | 91.3  | 3.30361e7 |
| 3     | 2014-05-28 | 90.97 | 91.1  | 90.64 | 90.72 | 3.04781e7 |
| 4     | 2014-05-27 | 90.28 | 91.02 | 90.2  | 91.0  | 2.97252e7 |
| 5     | 2014-05-23 | 89.33 | 89.9  | 89.12 | 89.88 | 2.26913e7 |
| 6     | 2014-05-22 | 88.94 | 89.48 | 88.8  | 89.23 | 3.06171e7 |
| 7     | 2014-05-21 | 88.16 | 88.89 | 88.11 | 88.84 | 3.68377e7 |
| 8     | 2014-05-20 | 88.28 | 88.6  | 87.64 | 88.0  | 3.3716e7  |
| 9     | 2014-05-19 | 87.47 | 88.46 | 87.3  | 88.32 | 3.2017e7  |
⋮
| 91    | 2014-01-21 | 88.43 | 88.59 | 87.81 | 88.55 | 2.64323e7 |
| 92    | 2014-01-17 | 88.12 | 88.37 | 87.67 | 87.88 | 3.69082e7 |
| 93    | 2014-01-16 | 88.28 | 88.51 | 88.16 | 88.38 | 3.42602e7 |
| 94    | 2014-01-15 | 88.0  | 88.54 | 87.94 | 88.37 | 3.98597e7 |
| 95    | 2014-01-14 | 86.3  | 87.72 | 86.3  | 87.65 | 3.71941e7 |
| 96    | 2014-01-13 | 87.18 | 87.48 | 85.68 | 86.01 | 4.88552e7 |
| 97    | 2014-01-10 | 87.24 | 87.4  | 86.58 | 87.3  | 3.80121e7 |
| 98    | 2014-01-09 | 87.62 | 87.64 | 86.72 | 87.02 | 2.36957e7 |
| 99    | 2014-01-08 | 87.11 | 87.55 | 86.94 | 87.31 | 2.721e7   |
| 100   | 2014-01-07 | 86.7  | 87.25 | 86.56 | 87.12 | 2.59132e7 |
```

## Searching data

You can search the quandl database using the `quandlsearch` function. This function supports one positional argument (the string you are searching for), and four keyword arguments:

- `page`, which  is the page returned by the search (default is `1`);
- `results`, which is the number of the results per-page (default is `20`);
- `quiet`, which indicates whether the function prints information on screen or not (default is `false`);
- `format`, which is the datatype where output is aggregated (default is `"DataFrame"`, but you can also use `"Dict"`).

```julia
julia> df = quandlsearch("GDP USA", results=30)
Returning 30 results of 746200 from page 1
30x5 DataFrame
|-------|-----------|-------------|---------|
| Col # | Name      | Eltype      | Missing |
| 1     | Code      | ASCIIString | 0       |
| 2     | Name      | ASCIIString | 0       |
| 3     | Frequency | ASCIIString | 0       |
| 4     | From      | ASCIIString | 0       |
| 5     | To        | ASCIIString | 0       |

julia> names(df)
5-element Array{Symbol,1}:
 :Code     
 :Name     
 :Frequency
 :From     
 :To

julia> df[:Name]
30-element DataArray{ASCIIString,1}:
 "United States: GDP (current LCU)"                      
 "United States: GDP growth (annual %)"                  
 "United States: GDP deflator, LCU"                      
 "United States: GDP (constant LCU)"                     
 "France: GDP, current US\$, millions"                   
 "Netherlands: GDP Potential, constant US\$, millions"   
 "India: GDP Discrepancy, current US\$, millions"        
 "Lesotho: GDP Discrepancy, current US\$, millions"      
 "Vanuatu: GDP (constant 2000 US\$)"                     
 "Fiji: GDP, current US\$, millions"                     
 ⋮                                                       
 "Czech Republic: GDP (current US\$)"                    
 "Grenada: GDP (current US\$)"                           
 "Mauritania: GDP (current US\$)"                        
 "Ethiopia: GDP, current US\$, millions"                 
 "South Africa: GDP, constant US\$, millions"            
 "Pakistan: GDP (constant 2000 US\$)"                    
 "Albania: GDP Discrepancy, constant US\$, millions"     
 "Nepal: GDP (constant 2000 US\$)"                       
 "Mongolia: GDP Discrepancy, constant US\$, millions"    
 "United States: GDP Discrepancy, constant LCU, millions"
```
A dictionary datatype is also supported. 

```julia
julia> s = quandlsearch("GDP USA", format="Dict"); # Here 's' is an array of dictionaries

julia> s[1] # This first dictionary looks ugly on REPL
["from_date"=>"1960-12-31","code"=>"USA_NY_GDP_MKTP_CN","name"=>"United States: GDP (current LCU)","source_code"=>"WORLDBANK","id"=>2582933,"updated_at"=>"2014-05-17T12:32:40Z","private"=>false,"description"=>"GDP at purchaser's prices is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources. Data are in current local currency.\nGDP (current LCU)","urlize_name"=>"United-States-GDP-current-LCU","display_url"=>"http://api.worldbank.org/countries/USA/indicators/NY.GDP.MKTP.CN?per_page=1000","column_names"=>{"Date","Value"},"source_name"=>"World Bank","frequency"=>"annual","type"=>nothing,"to_date"=>"2012-12-31"]

julia> s[1]["name"]
"United States: GDP (current LCU)"

julia> s[1]["updated_at"]
"2014-05-17T12:32:40Z"
```

## Interactive search
Our API also provides a interactive search environment to be used inside Julia's REPL. To use it, simply call `interactivequandl` function.

```julia
julia> a = interactivequandl("USA GDP")

1 WORLDBANK/USA_NY_GDP_MKTP_CN   From 1960-12-31 to 2012-12-31
    United States: GDP (current LCU)
2 WORLDBANK/USA_NY_GDP_MKTP_KD_ZG   From 1961-12-31 to 2012-12-31
    United States: GDP growth (annual %)
3 WORLDBANK/USA_NYGDPMKTPXN   From 1960-12-31 to 2015-12-31
    United States: GDP deflator, LCU
4 WORLDBANK/USA_NY_GDP_MKTP_KN   From 1960-12-31 to 2012-12-31
    United States: GDP (constant LCU)
5 WORLDBANK/FRA_NYGDPMKTPCD   From 1960-12-31 to 2015-12-31
    France: GDP, current US$, millions
6 WORLDBANK/NLD_NYGDPPOTLKD   From 1961-12-31 to 2015-12-31
    Netherlands: GDP Potential, constant US$, millions
7 WORLDBANK/IND_NYGDPDISCCD   From 1960-12-31 to 2015-12-31
    India: GDP Discrepancy, current US$, millions
8 WORLDBANK/LSO_NYGDPDISCCD   From 1960-12-31 to 2015-12-31
    Lesotho: GDP Discrepancy, current US$, millions
9 WORLDBANK/VUT_NY_GDP_MKTP_KD   From 1979-12-31 to 2012-12-31
    Vanuatu: GDP (constant 2000 US$)
10 WORLDBANK/FJI_NYGDPMKTPCD   From 1960-12-31 to 2014-12-31
    Fiji: GDP, current US$, millions
11 WORLDBANK/ECU_NYGDPPOTLKD   From 1961-12-31 to 2015-12-31
    Ecuador: GDP Potential, constant US$, millions
12 WORLDBANK/LBY_NYGDPMKTPKD   From nothing to nothing
    Libya: GDP, constant US$, millions
13 WORLDBANK/ERI_NY_GDP_MKTP_CD   From 1992-12-31 to 2012-12-31
    Eritrea: GDP (current US$)
14 WORLDBANK/UZB_NY_GDP_MKTP_CD   From 1990-12-31 to 2012-12-31
    Uzbekistan: GDP (current US$)
15 WORLDBANK/CZE_NYGDPMKTPKD   From 1961-12-31 to 2015-12-31
    Czech Republic: GDP, constant US$, millions
16 WORLDBANK/SLV_NY_GDP_MKTP_CD   From 1960-12-31 to 2012-12-31
    El Salvador: GDP (current US$)
17 WORLDBANK/ARG_NY_GDP_MKTP_CD   From 1962-12-31 to 2012-12-31
    Argentina: GDP (current US$)
18 WORLDBANK/USA_NY_GNS_ICTR_ZS   From 1970-12-31 to 2012-12-31
    United States: Gross savings (% of GDP)
19 WORLDBANK/SOM_NY_GDP_MKTP_CD   From 1960-12-31 to 1990-12-31
    Somalia: GDP (current US$)
20 WORLDBANK/TZA_NY_GDP_MKTP_KD   From 1988-12-31 to 2012-12-31
    Tanzania: GDP (constant 2000 US$)

==> Enter n° of the dataset to be downloaded | (N)ext page | (Q)uit
-------------------------------------------------------------------
==>
```

On the REPL, however, the environment is printed with colors, so it's easier to read.

This function supports one positional argument (the string you are searching for), and eight keyword arguments:

- `page`, which  is the page returned by the search (default is `page=1`);
- `results`, which is the number of the results per-page (default is  `results=20`);
- `order`, which is the order in which the returned Dataset is sorted (default is `des`);
- `rows`, which is the number of rows that the returned Dataset will have (default is `100`);
- `frequency`, which is the frequency desired for the Dataset (default is `daily`);
- `transformation`, which is the calculation Quandl do to to Dataset prior to download (default is `none`);
- `auth_key`, which is user's API key (see the next section for further information);
- `format`, which is the type returned by the function (default is `"TimeArray"`, but you can use `"DataFrame"` also)

## Setting your API key

You can use this package without an auth token, but it's recommended you get one from Quandl.com, since you are limited to 10 downloads per day
without it. Once you get a token (creating an account on Quandl is enough), you'll only need to replace the text in the `src/token/auth_token.jl` file with your unique token. Don't leave any whitespace or extra lines. Every time you upgrade or re-install this package, you'll need to do this extra step.

An another way of doing this, is by using the `set_auth_token` function:

```julia
julia> set_auth_token("1234567890") # You pass a string with your API key to this function
```

The package will use your unique token automatically, or if you choose to remain anonymous and don't care about more than 10 downloads per day, it
will make an anonymous call.

You can also call `quandl` function using the `auth_token` argument. That way, the program will use it instead of the token stored on the file, if you have one.

## More

See [Quandl API Help Page](http://www.quandl.com/help/api) for further explanations. The Julia API closely follows the nomenclature used by their documentation.
