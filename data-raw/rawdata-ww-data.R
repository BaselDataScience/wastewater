## code to prepare `rawdata/ww-data-long-2023-05-02.csv` dataset goes here

ww_data <- readr::read_csv('rawdata/ww-data-long-2023-05-02.csv') %>%
  dplyr::select(-ends_with(' mean')) %>%
  dplyr::group_by(City, Metabolite, Year) %>%
  tidyr::pivot_longer(cols = dplyr::all_of(ww_weekdays), names_to = 'weekday') %>%
  dplyr::mutate(weekday = factor(weekday, labels = substring(ww_weekdays, 1, 3), levels = ww_weekdays, ordered = TRUE),
                Year = as.character(Year)) %>%
  dplyr::ungroup()

ww_cities <- sort(unique(ww_data$City))

# determine display colors and associate them with years
years <- as.character(sort(unique(ww_data$Year)))
ww_colors <- viridisLite::viridis(n=length(years), direction = -1)
names(ww_colors) <- years

usethis::use_data(ww_data, ww_cities, ww_colors, overwrite = TRUE)
