# usage.R
# pulling useful data from iLab usage tables

library(dplyr)
library(readr)
library(ggplot2)

# Import data ------

datapath <- "/Users/confocal/github_theresaswayne/data-analysis/R/usage_data"
#datafile <- "09012017_01312018_charges_report_source_data.csv"
datafile <- "03012017_03012018_charges_report_source_data.csv"

# unlike base R's read.csv, readr's read_csv gives a tbl that can be grouped
#usage <- read.csv(file.path(datapath, datafile)) 
usage <- read_csv(file.path(datapath, datafile)) # errors result, but seems ok

# to get the true total hours, select only microscopes, workstation, and chargeable services
equipment_usage <- dplyr::filter(usage, !grepl("Lenses", `Charge Name`)) 

# Group by assistance level ---------------------------------------------------
usage_by_assist <- group_by(equipment_usage, `Usage Type`)
hrs_by_assist <- summarise(usage_by_assist, hours = sum(Quantity))

# Add together assisted, training, and service ----------------------------
# assisted use = contains "Assisted", "Training", or "1" [1 = Img Proc service]
# non-assisted use = contains "Unassisted" or "Independent"

hrs_assisted <- dplyr::filter(hrs_by_assist, grepl("Assisted|Training|1", `Usage Type`)) 
total_assisted <- sum(hrs_assisted$hours)

hrs_unass <- dplyr::filter(hrs_by_assist, grepl("Unassisted|Independent", `Usage Type`)) 
total_unass <- sum(hrs_unass$hours)

#total_hours <- sum(hrs_by_assist$hours)

headers <- c("Usage Type","Hours")
usage_type <- c("Assisted/Service", "Non-Assisted")
hours <- c(total_assisted, total_unass)

hrs_summ <- cbind(usage_type, hours) %>%
  as.data.frame(stringsAsFactors = FALSE)

hrs_summ$hours <- as.numeric(as.character(hrs_summ$hours))

hrs_summ <- mutate(hrs_summ, 
                hrs_pct = hours / sum(hours))
