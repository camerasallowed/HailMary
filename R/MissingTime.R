#' Calculates Missing Data Over Time
#'
#' Calculates the percentage of missing values for a selected variable
#' grouped by year and month.Can be used to plot.
#'
#' @param con The name of the created database.
#' @param column Character string. Created by the user to specify the column
#' of interest (e.g., \code{"Temp_C"}).
#'
#' @return A data frame with:
#' \itemize{
#'   \item Year
#'   \item Month
#'   \item total_obs
#'   \item missing_count
#'   \item pct_missing
#'   \item time_label
#' }
#'


get_missing_over_time <- function(con, column) {

  query <- paste0("
    SELECT
      substr(DateTime, 1, 4) AS Year,
      substr(DateTime, 6, 2) AS Month,
      COUNT(*) AS total_obs,
      SUM(", column, " IS NULL) AS missing_count
    FROM Observation
    GROUP BY Year, Month
    ORDER BY Year, Month
  ")

  df <- dbGetQuery(con, query)

  df$pct_missing <- (df$missing_count / df$total_obs) * 100
  df$time_label <- paste(df$Year, df$Month, sep = "-")

  df
}


