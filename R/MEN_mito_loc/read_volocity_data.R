# read_volocity_file.R
# generates and cleans a single csv file exported from Volocity 6.3


# Setup -------
require(readr)
require(here)

# ENTER FILENAME HERE ----------
# NOTE -- assumes everything is in a directory called "data" in the project home
subfolder <- "2019-01-03 measurements"
dataname <- "20181213_GTY029_25C_1_measurements.csv"


# Read file
#   locale prevents multibyte string error
#   na converts Volocity's "N/A" into R <NA>, 
#     and allows columns with NA's to be auto-read as numeric

# Read a single results file ------------
single_meas <- read_csv(here("data", file.path(subfolder,dataname)),
              locale = locale(encoding = "latin1"),
              na = c("", "N/A"))

dataname <- "20181213 GTY029_25C_1-4_measurements_no_roi.csv"

multi_meas <- read_csv(here("data", dataname),
                        locale = locale(encoding = "latin1"),
                        na = c("", "N/A"))

single_meas2 <- read_csv(here("data", "20181213 GTY029_25C_2_measurements.csv"),
                      locale = locale(encoding = "latin1"),
                      na = c("", "N/A"))

single_meas1b <- read_csv(here("data", "20181213 GTY029_25C_1_measurements_no_roi.csv"),
                         locale = locale(encoding = "latin1"),
                         na = c("", "N/A"))

# TODO: clean data (remove preliminary whole cells)

# TODO: merge data from all cells in an experiment
