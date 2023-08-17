#' Wastewater drug metabolite data
#'
#' The data source from the EMCDDA and SCORE projects
#'
#' @format ## `ww_data`
#' A data frame with 21560 rows and 7 columns:
#' \describe{
#'   \item{Year}{year of measurement}
#'   \item{Metabolite}{drug category for which metabolites were measured}
#'   \item{Site ID}{short identifier for city where wastewater was collected}
#'   \item{Country}{2-letter abbreviation of the country to which city belongs}
#'   \item{City}{city where wastwater was collected}
#'   \item{weekday}{3-letter English abbreviation of weekday of measurement}
#'   \item{value}{estimated amount of drug per day and per 1000 inhabitants in mg}
#' }
#' @source <https://www.emcdda.europa.eu/publications/html/pods/waste-water-analysis_en#sourceDataa>
"ww_data"
