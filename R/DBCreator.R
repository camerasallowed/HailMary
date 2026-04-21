#' Builds Climate SQLite Database from Environment Canada Data
#'
#' Creates an RSQLite database containing Station and Observation tables
#' using station metadata and hourly climate CSV files.
#'
#' @param db_path The pathway to output the RSQLite database file.
#' @param data_dir The directory containing the hourly observation CSV files.
#'
#' @return NULL. Creates a VERY large database in the designated location.
#' Ensure you have the space prior to running this command.
#'
#' @details Station metadata is read from the package using
#' \code{system.file("extdata", "hourly_climate_stations.csv")}.
#'
#' @import DBI
#' @import RSQLite
#' @import dplyr
#' @import tidyr
#'
#'

build_climate_database <- function(
    db_path = "climate_data.sqlite",
    data_dir = "hourly_climate_data"
) {

  library(DBI)
  library(RSQLite)
  library(dplyr)
  library(tidyr)

  stations <- read.csv(get_station_file(), skip = 3, header = TRUE)

  stations_clean <- stations %>%
    rename(
      Climate_ID = Climate.ID,
      Station_Name = Name,
      Province_Name = Province,
      HLY_First_Year = HLY.First.Year,
      HLY_Last_Year = HLY.Last.Year
    ) %>%
    filter(!is.na(HLY_First_Year), !is.na(HLY_Last_Year))

  files <- list.files(data_dir, pattern = "\\.csv$", full.names = TRUE)
  files <- files[file.info(files)$size > 0]

  obs_raw <- do.call(rbind, lapply(files, read.csv))

  obs_clean <- obs_raw %>%
    select(
      Climate.ID,
      Date.Time..LST.,
      Temp...C.,
      Dew.Point.Temp...C.,
      Rel.Hum....,
      Precip..mm.,
      Wind.Dir..10s.deg.,
      Wind.Spd..km.h.,
      Visibility..km.,
      Stn.Press..kPa.,
      Hmdx,
      Wind.Chill,
      Weather
    ) %>%
    rename(
      Climate_ID = Climate.ID,
      DateTime = Date.Time..LST.,
      Temp_C = Temp...C.,
      Dew_Point_C = Dew.Point.Temp...C.,
      Rel_Hum = Rel.Hum....,
      Precip_Amount = Precip..mm.,
      Wind_Dir_deg = Wind.Dir..10s.deg.,
      Wind_Spd_kmh = Wind.Spd..km.h.,
      Visibility_km = Visibility..km.,
      Stn_Press_kPa = Stn.Press..kPa.
    ) %>%
    mutate(
      flags = is.na(Temp_C) | is.na(Rel_Hum) | is.na(Precip_Amount)
    )

  con <- dbConnect(SQLite(), db_path)

  dbExecute(con, "
    CREATE TABLE IF NOT EXISTS Station (
      Climate_ID INTEGER PRIMARY KEY,
      Station_Name TEXT,
      Province_Name TEXT,
      Latitude REAL,
      Longitude REAL,
      Elevation REAL,
      HLY_First_Year INTEGER,
      HLY_Last_Year INTEGER
    );
  ")

  dbExecute(con, "
    CREATE TABLE IF NOT EXISTS Observation (
      Climate_ID INTEGER,
      DateTime TEXT,
      Temp_C REAL,
      Dew_Point_C REAL,
      Rel_Hum REAL,
      Precip_Amount REAL,
      Wind_Dir_deg REAL,
      Wind_Spd_kmh REAL,
      Visibility_km REAL,
      Stn_Press_kPa REAL,
      Hmdx REAL,
      Wind_Chill REAL,
      Weather TEXT,
      flags INTEGER,
      FOREIGN KEY (Climate_ID) REFERENCES Station(Climate_ID)
    );
  ")

  dbWriteTable(con, "Station", stations_clean, overwrite = TRUE)
  dbWriteTable(con, "Observation", obs_clean, overwrite = TRUE)

  dbDisconnect(con)
}
