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
subfolder <- "2019-01-03 and 04 meas cells w mito bg roi"

# Read all the files in the folder ------

inputFolder <- here(file.path("data",subfolder))
outputFolder <- here("data")

# get file names
files <- dir(inputFolder, pattern = "*.csv") 

# tibble is used because of the warning that data_frame is deprecated.
mergedDataWithNames <- tibble(filename = files) %>% # tibble holding file names
  mutate(file_contents =
           map(filename,          # read files into a new data column
               ~ read_csv(file.path(inputFolder, .),
                          locale = locale(encoding = "latin1"),
                          na = c("", "N/A"),
                          col_types = cols(`Number of contained Mito` = col_double(),
                                           `Compartment Whole cells ID` = col_double()))))

# unnest to make the list into a flat file again,
# but it now has 1 extra column to hold the filename
mergedDataFlat <- unnest(mergedDataWithNames)

# mergedDataWithNames has correctly, 49 entries (1 per file)

# Simplify -------

df <- filter(mergedDataFlat, Population != "Whole cells prelim") %>%
  select(-contains("Trans")) %>%
  arrange(filename,ID)


# Write an output file of all the merged data ----------

#outputFile = paste(subfolder, Sys.Date(), "merged.csv") # spaces will be inserted
#write_csv(df,file.path(outputFolder, outputFile))

