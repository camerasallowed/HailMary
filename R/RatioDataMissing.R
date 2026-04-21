#' Calculates Missing Data Ratios for Selected Variables
#'
#' Calculates the proportion of missing values (NA/NULL) for selected variables.
#'
#' @param con The name of the created database.
#' @param columns Character vector. Created by the user to specify the column
#' of interest (e.g., \code{c("Temp_C", "Rel_Hum")}).
#'
#' @return A one-row data frame containing missing value proportions.
#'
#' @import DBI
#'
#'
#'
#'
get_missing_ratio <- function(con, columns) {

  parts <- paste0(
    "AVG(", columns, " IS NULL) AS miss_", columns
  )

  query <- paste0(
    "SELECT ", paste(parts, collapse = ", "),
    " FROM Observation"
  )

  dbGetQuery(con, query)
}


