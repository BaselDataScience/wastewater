## code to prepare `rawdata/ww-sites-2023-05-02.csv` dataset goes here

sites <- readr::read_csv('rawdata/ww-sites-2023-05-02.csv')
usethis::use_data(sites, overwrite = TRUE)
