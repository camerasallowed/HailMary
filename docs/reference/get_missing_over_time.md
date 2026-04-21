# Calculates Missing Data Over Time

Calculates the percentage of missing values for a selected variable
grouped by year and month.Can be used to plot.

## Usage

``` r
get_missing_over_time(con, column)
```

## Arguments

- con:

  The name of the created database.

- column:

  Character string. Created by the user to specify the column of
  interest (e.g., `"Temp_C"`).

## Value

A data frame with:

- Year

- Month

- total_obs

- missing_count

- pct_missing

- time_label
