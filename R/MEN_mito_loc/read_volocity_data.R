

require(readr)
require(here)

# enter filename here
dataname <- "20181213_GTY029_25C_1_measurements.csv"

# locale setting prevents multibyte string error
# na setting converts Volocity's "N/A" into R <NA> and also lets columns with NA's become numeric

single_meas <- read_csv(here("data", dataname),
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