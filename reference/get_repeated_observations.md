# Identify Consecutive Repeated Observations

Detects consecutive repeated values for a user specified variable

## Usage

``` r
get_repeated_observations(con, column)
```

## Arguments

- con:

  The name of the created database.

- column:

  Character string. Created by the user to specify the column of
  interest (e.g., `"Temp_C"`).

## Value

A data frame of rows where consecutive values are repeated.
