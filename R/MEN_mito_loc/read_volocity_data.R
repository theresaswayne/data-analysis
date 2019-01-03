

require(readr)
require(here)

# enter filename here
dataname <- "20181213_GTY029_25C_1_measurements.csv"

# locale setting prevents multibyte string error
# na setting converts Volocity's "N/A" into R <NA> and also lets columns with NA's become numeric

d <- read_csv(here("data", dataname),
              locale = locale(encoding = "latin1"),
              na = c("", "N/A"))
