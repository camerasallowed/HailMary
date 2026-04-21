# Identifies Missing Hourly Time Gaps

Checks for time gaps greater than one hour between consecutive
observations.

## Usage

``` r
get_time_gaps(con)
```

## Arguments

- con:

  The name of the created database.

## Value

A data frame containing observations where time gaps exceed one hour.
