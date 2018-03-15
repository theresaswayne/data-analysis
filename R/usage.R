# usage.R
# pulling useful data from iLab usage tables

library(dplyr)
library(readr)

# Import data ------

datapath <- "/Users/confocal/github_theresaswayne/data-analysis/R/usage_data"
#datafile <- "09012017_01312018_charges_report_source_data.csv"
datafile <- "03012017_03012018_charges_report_source_data.csv"

# unlike base R's read.csv, readr's read_csv gives a tbl that can be grouped
usage <- read_csv(file.path(datapath, datafile)) # errors result, but seems ok

# Filter by date ----------------------------------------------------------
#usage <- filter(usage, `Completion Date` > "2018-01-01")

# Calculate hours based on Usage Type column ------------------------------

hrs_assist <- dplyr::filter(usage, grepl("Assisted|Training|1", `Usage Type`)) %>%
  dplyr::select(Quantity) %>%
  sum()

hrs_unass <- dplyr::filter(usage, grepl("Unassisted|Independent", `Usage Type`)) %>%
  dplyr::select(Quantity) %>%
  sum()


# Summarize ---------------------------------------------------------------

usage_type <- c("Assisted/Service", "Non-Assisted")
hours <- c(hrs_assist, hrs_unass)

hrs_summ <- cbind(`Usage Type` = usage_type, Hours = hours) %>%
  as.data.frame(stringsAsFactors = FALSE)

hrs_summ$Hours <- as.numeric(as.character(hrs_summ$Hours)) # force R to see the hours as numeric

hrs_summ <- mutate(hrs_summ, 
                   Percent = round((Hours / sum(Hours)), 2))
