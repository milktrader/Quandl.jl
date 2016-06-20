Getting Data
============

The ``quandl`` (or ``quandlget``) function takes one positional argument
(the Quandl code for the database you wish to download) and currently
supports six keyword arguments:

-  ``order``, which is the order in which the returned Dataset is sorted
   (default is ``des``);
-  ``rows``, which is the number of rows that the returned Dataset will
   have (default is ``100``);
-  ``frequency``, which is the frequency desired for the Dataset
   (default is ``daily``);
-  ``transformation``, which is the calculation Quandl do to to Dataset
   prior to download (default is ``none``);
-  ``from``, which is the starting date for the Dataset (default is
   ``""``);
-  ``to``, which is the ending date for the Dataset (default is ``""``);
-  ``format``, which is the type returned by the function (default is
   ``"TimeArray"``, but you can use ``"DataFrame"`` also).
-  ``api_key``, which can be used to set your own API key from quandl.com

::

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

You can also dowload your data into a DataFrame.

::

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
