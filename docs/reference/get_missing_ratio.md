# Calculates Missing Data Ratios for Selected Variables

Calculates the proportion of missing values (NA/NULL) for selected
variables.

## Usage

``` r
get_missing_ratio(con, columns)
```

## Arguments

- con:

  The name of the created database.

- columns:

  Character vector. Created by the user to specify the column of
  interest (e.g., `c("Temp_C", "Rel_Hum")`).

## Value

A one-row data frame containing missing value proportions.
