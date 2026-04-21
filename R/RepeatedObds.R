#' Identify Consecutive Repeated Observations
#'
#' Detects consecutive repeated values for a user specified variable
#'
#' @param con The name of the created database.
#' @param column Character string. Created by the user to specify the column
#' of interest (e.g., \code{"Temp_C"}).
#'
#' @return A data frame of rows where consecutive values are repeated.
#'
#'
#'
#'

get_repeated_observations <- function(con, column) {

  query <- paste0(
    "SELECT *
     FROM (
       SELECT
         Climate_ID,
         DateTime,
         ", column, ",
         LAG(", column, ") OVER (
           PARTITION BY Climate_ID
           ORDER BY DateTime
         ) AS prev_val
       FROM Observation
     )
     WHERE ", column, " = prev_val"
  )

  dbGetQuery(con, query)
}

