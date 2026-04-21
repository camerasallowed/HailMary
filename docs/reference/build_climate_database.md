# Builds Climate SQLite Database from Environment Canada Data

Creates an RSQLite database containing Station and Observation tables
using station metadata and hourly climate CSV files.

## Usage

``` r
build_climate_database(
  db_path = "climate_data.sqlite",
  data_dir = "hourly_climate_data"
)
```

## Arguments

- db_path:

  The pathway to output the RSQLite database file.

- data_dir:

  The directory containing the hourly observation CSV files.

## Value

NULL. Creates a VERY large database in the designated location. Ensure
you have the space prior to running this command.

## Details

Station metadata is read from the package using
`system.file("extdata", "hourly_climate_stations.csv")`.
