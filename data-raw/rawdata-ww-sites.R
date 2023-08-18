## code to prepare `rawdata/ww-sites-2023-05-02.csv` dataset goes here

ww_sites <- readr::read_csv('rawdata/ww-sites-2023-05-02.csv', col_types = 'ccccdddcc')
usethis::use_data(ww_sites, overwrite = TRUE)
