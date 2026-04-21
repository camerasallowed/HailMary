#' Checks for Missing Stations
#'
#' Compares the database station list with the hourly climate station list.
#'
#' @param con The name of the created database.
#'
#' @return A list of any stations that are missing in the created database.
#'
#'
#'
#'

check_missing_stations <- function(con) {

  station_csv <- get_station_file()

  stations_csv <- read.csv(station_csv, skip = 3, header = TRUE)
  stations_csv <- dplyr::rename(stations_csv, Station_Name = Name)

  db_names <- dbGetQuery(con, "
    SELECT Station_Name FROM Station
  ")$Station_Name

  setdiff(stations_csv$Station_Name, db_names)
}


