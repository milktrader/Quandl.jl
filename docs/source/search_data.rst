Searching Data
==============

You can search the quandl database using the ``quandlsearch`` function.
This function supports one positional argument (the string you are
searching for), and four keyword arguments:

-  ``page``, which is the page returned by the search (default is
   ``1``);
-  ``results``, which is the number of the results per-page (default is
   ``20``);
-  ``quiet``, which indicates whether the function prints information on
   screen or not (default is ``false``);
-  ``format``, which is the datatype where output is aggregated (default
   is ``"DataFrame"``, but you can also use ``"Dict"``).

::

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

A dictionary datatype is also supported.

::

    julia> s = quandlsearch("GDP USA", format="Dict"); # Here 's' is an array of dictionaries

    julia> s[1] # This first dictionary looks ugly on REPL
    ["from_date"=>"1960-12-31","code"=>"USA_NY_GDP_MKTP_CN","name"=>"United States: GDP (current LCU)","source_code"=>"WORLDBANK","id"=>2582933,"updated_at"=>"2014-05-17T12:32:40Z","private"=>false,"description"=>"GDP at purchaser's prices is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for depletion and degradation of natural resources. Data are in current local currency.\nGDP (current LCU)","urlize_name"=>"United-States-GDP-current-LCU","display_url"=>"http://api.worldbank.org/countries/USA/indicators/NY.GDP.MKTP.CN?per_page=1000","column_names"=>{"Date","Value"},"source_name"=>"World Bank","frequency"=>"annual","type"=>nothing,"to_date"=>"2012-12-31"]

    julia> s[1]["name"]
    "United States: GDP (current LCU)"

    julia> s[1]["updated_at"]
    "2014-05-17T12:32:40Z"

Interactive search
------------------

Our API also provides a interactive search environment to be used inside
Julia's REPL. To use it, simply call ``interactivequandl`` function.

::

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

In REPL, the environment is printed with color and is easier to read.

This function supports one positional argument (the string you are
searching for), and eight keyword arguments:

-  ``page``, which is the page returned by the search (default is
   ``page=1``);
-  ``results``, which is the number of the results per-page (default is
   ``results=20``);
-  ``order``, which is the order in which the returned Dataset is sorted
   (default is ``des``);
-  ``rows``, which is the number of rows that the returned Dataset will
   have (default is ``100``);
-  ``frequency``, which is the frequency desired for the Dataset
   (default is ``daily``);
-  ``transformation``, which is the calculation Quandl do to to Dataset
   prior to download (default is ``none``);
-  ``auth_key``, which is user's API key (see the next section for
   further information);
-  ``format``, which is the type returned by the function (default is
   ``"TimeArray"``, but you can use ``"DataFrame"`` also)
