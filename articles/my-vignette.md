# Climate Data Package

``` r
library(HailMary)
```

### Abstract

The name explains it all, this is a package that is meant to help
process the immense amount of data from Climate Canada. Does it work?
Hopefully! But I make no promises. This is very simple in its structure
and format, so it is limited in what it will do. This package
specifically includes: - A database creation function (labelled con) -
Embedded meta data listing all current weather stations in Canada -
Sanity checks that both check the database and can help create either
dataframes or plots

### Added Functions:

- ‘build_climate_database()’ : Creates the database
- ‘check_missing_stations()’ : Compares stations in the database to the
  metadata
- ‘get_repeated_observations()’: Checks for repeated observations
- ‘get_time_gaps()’ : Checks for data time gaps greater than 1 hour
- ‘get_observation_ranges()’ : Min and Max observation ranges for all
  stations
- ‘get_missing_over_time()’ : Percentage of missing data
- ‘get_missing_ratio()’ : Proportion of missing data
- ‘get_station_file()’ : Accesses the embedded meta data ; does not need
  to be run by the user

### Column

Some functions require a column variable that must be created client
side that specifies a specific variable to analyse. An example of this
is:

``` r
column <- "Temp_C"
```

### Columns

Some functions require a columns variable that must be created client
side that specifies variables to analyse.

``` r
columns <- c("Temp_C","Rel_Hum")
```

### Database Naming Scheme: Tables and Variables

## Station Table

- Climate_ID
- Station_Name
- Province_Name
- Latitude
- Longitude
- Elevation
- HLY_First_Year
- HLY_Last_Year

## Observation Table

- Climate_ID
- DateTime
- Temp_C
- Dew_Point_C
- Rel_Hum
- Precip_Amount
- Wind_Dir-deg
- Wind-Spd_kmh
- Visibility
- Stn_Press_kPa
- Hmdx
- Wind_Chill
- Weather
- flags
