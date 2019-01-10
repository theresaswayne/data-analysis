# test_string_match.R
# testing retrieval of factors from filename text

require(dplyr)
require(stringr)

filename <- c("GTY029 25C 2 (cropped)_01_c10m-80.csv",
              "GTY029 25C 6 (cropped)_03_c50m-50.csv",
              "GTY029 25C 9 (cropped)_05_c40m200.csv")

verify <- c(-80, -50, 200) # ground truth

tbl <- cbind(filename, verify) %>% as_tibble()

captured <- str_extract(filename, m(.*)\.csv)