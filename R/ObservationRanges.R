#' Get Observation Time Ranges by Station
#'
#' Shows the time span and total number of observations for each station.
#'
#' @param con The name of the created database.
#'
#' @return A data frame containing:
#' \itemize{
#'   \item Climate_ID
#'   \item start_date
#'   \item end_date
#'   \item n_obs
#' }


get_observation_ranges <- function(con) {

  query <- "
    SELECT
      Climate_ID,
      MIN(DateTime) AS start_date,
      MAX(DateTime) AS end_date,
      COUNT(*) AS n_obs
    FROM Observation
    GROUP BY Climate_ID
  "

  dbGetQuery(con, query)
}


