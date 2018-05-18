# usage.R
# pulling useful data from iLab usage tables

library(dplyr)
library(readr)

# Import data ------

datafile <- file.choose() # opens a file chooser window, no message

#datapath <- "/Users/confocal/github_theresaswayne/data-analysis/R/usage_data"
#datapath <- "/Users/theresa/Documents/home-github/data-analysis/R/usage_data"
#datafile <- "09012017_01312018_charges_report_source_data.csv"
#datafile <- "01012018_03012018_charges_report_source_data.csv"
#datafile <- "01012017_01012018_charges_report_source_data.csv"

# unlike base R's read.csv, readr's read_csv gives a tbl that can be grouped
#usage <- read_csv(file.path(datapath, datafile)) # errors result, but seems ok
usage <- read_csv(file.path(datafile)) # errors result, but seems ok

# Optional filter by date ----------------------------------------------------------
#usage <- filter(usage, `Completion Date` > "2018-03-01")


# Assisted vs Non-assisted ------------------------------------------------

# Calculate hours based on Usage Type column
hrs_assist <- dplyr::filter(usage, grepl("Assisted|Training|1", `Usage Type`)) %>%
  dplyr::select(Quantity) %>%
  sum()

hrs_unass <- dplyr::filter(usage, grepl("Unassisted|Independent", `Usage Type`)) %>%
  dplyr::select(Quantity) %>%
  sum()

# Summarize
usage_type <- c("Assisted/Service", "Non-Assisted")
hours <- c(hrs_assist, hrs_unass)

hrs_assist_summ <- cbind(`Usage Type` = usage_type, Hours = hours) %>%
  as.data.frame(stringsAsFactors = FALSE)

hrs_assist_summ$Hours <- as.numeric(as.character(hrs_assist_summ$Hours)) # force R to see the hours as numeric

hrs_assist_summ <- mutate(hrs_assist_summ, 
                   Percent = round((Hours / sum(Hours)), 2))


# HICCC vs non  ------------------------------------------------------------

eqpt_service_usage <- dplyr::filter(usage, !grepl("Lenses", `Charge Name`))

hrs_HICCC <- dplyr::filter(eqpt_service_usage, grepl("Cancer Center Member", `Price Type`)) %>%
  dplyr::select(Quantity) %>%
  sum()

hrs_NonHICCC <- dplyr::filter(eqpt_service_usage, grepl("Dept of Pathology|Internal - Columbia|External - Academic", `Price Type`)) %>%
  dplyr::select(Quantity) %>%
  sum()

appts_HICCC <- dplyr::filter(eqpt_service_usage, grepl("Cancer Center Member", `Price Type`)) %>%
  dplyr::select(`Customer Lab`)

appts_HICCC$`Customer Lab` <- factor(appts_HICCC$`Customer Lab`)
users_HICCC <- nlevels(appts_HICCC$`Customer Lab`)

appts_NonHICCC <- dplyr::filter(eqpt_service_usage, grepl("Dept of Pathology|Internal - Columbia|External - Academic", `Price Type`)) %>%
  dplyr::select(`Customer Lab`)

appts_NonHICCC$`Customer Lab` <- factor(appts_NonHICCC$`Customer Lab`)
users_NonHICCC <- nlevels(appts_NonHICCC$`Customer Lab`)

# Summarize
price_type <- c("HICCC", "Non-HICCC")
hoursCC <- c(hrs_HICCC, hrs_NonHICCC)
usersCC <- c(users_HICCC, users_NonHICCC)

hrs_cc_summ <- cbind(`Price Type` = price_type, Hours = hoursCC, Labs = usersCC) %>%
  as.data.frame(stringsAsFactors = FALSE)

hrs_cc_summ$Hours <- as.numeric(as.character(hrs_cc_summ$Hours)) # force R to see the hours as numeric

hrs_cc_summ <- mutate(hrs_cc_summ, 
                   HrsPercent = round((Hours / sum(Hours)), 2))

hrs_cc_summ$Labs <- as.numeric(as.character(hrs_cc_summ$Labs)) # force R to see the labs as numeric

hrs_cc_summ <- mutate(hrs_cc_summ, 
                      LabsPercent = round((Labs / sum(Labs)), 2))
