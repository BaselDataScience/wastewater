## code to prepare `rawdata/ww-data-long-2023-05-02.csv` dataset goes here

ww_data <- readr::read_csv('rawdata/ww-data-long-2023-05-02.csv') %>%
  dplyr::group_by(City, Metabolite, Year) %>%
  tidyr::pivot_longer(cols = dplyr::all_of(ww_weekdays)) %>%
  dplyr::mutate(name = factor(name, labels = substring(ww_weekdays, 1, 3), levels = ww_weekdays, ordered = TRUE))

cities <- sort(unique(ww_data$City))

usethis::use_data(ww_data, cities, overwrite = TRUE)
