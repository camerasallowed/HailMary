#' Identifies Missing Hourly Time Gaps
#'
#' Checks for time gaps greater than one hour between consecutive
#' observations.
#'
#' @param con The name of the created database.
#'
#' @return A data frame containing observations where time gaps exceed one hour.
#'
#'
#'


get_time_gaps <- function(con) {

  query <- "
    SELECT *
    FROM (
      SELECT
        Climate_ID,
        DateTime,
        LAG(DateTime) OVER (
          PARTITION BY Climate_ID
          ORDER BY DateTime
        ) AS prev_dt
      FROM Observation
    )
    WHERE
      (strftime('%s', DateTime) - strftime('%s', prev_dt)) / 3600.0 > 1
  "

  dbGetQuery(con, query)
}


