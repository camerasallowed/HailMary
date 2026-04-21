#' Accesses embedded CSV
#'
#' @details Used by the other functions, does not need to be run by the user.
#'
#'
#'

get_station_file <- function() {
  path <- system.file(
    "extdata",
    "hourly_climate_stations.csv",
    package = "HailMary"
  )

  if (path == "") {
    stop("Station file not found in package.")
  }

  path
}

