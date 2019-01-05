# combine_volocity_files.R
# imports, merges, and simplifies a batch of csv files exported from Volocity 6.3
# Requirement: All files must be within a single folder in the "data" folder

# adapted from http://serialmentor.com/blog/2016/6/13/reading-and-combining-many-tidy-data-files-in-R

# Setup -------
require(readr)
require(here)
require(dplyr)
require(tidyr) # for unnest
require(purrr) # for reduce and map functions


# ENTER FOLDER NAME HERE ----------
# NOTE -- assumes everything is in a directory called "data" in the project home
subfolder <- "2019-01-03 measurements"

# Read all the files in the folder ------

inputFolder <- here(file.path("data",subfolder))
outputFolder <- here("data")

# get file names
files <- dir(inputFolder, pattern = "*.csv") 


mergedDataWithNames <- data_frame(filename = files) %>% # dataframe holding file names
  mutate(file_contents =
           map(filename,          # read files into a new data column
               ~ read_csv(file.path(inputFolder, .),
                          locale = locale(encoding = "latin1"),
                          na = c("", "N/A"))))

# unnest to make the list into a flat file again,
# but it now has 1 extra column to hold the filename
mergedDataFlat <- unnest(mergedDataWithNames)


# Simplify -------

df <- filter(mergedDataFlat, Population != "Whole cells prelim") %>%
  select(-contains("Trans"))


