# commands to filter usage reports from iLab against lists of labs

# setup
require(tidyverse)

# input data 

# read in a list to filter as "dldrc"
# save the last and first names
dldrc <- dldrc %>% select(MergedLast,MergedFirst)

# we have to filter on the combo of last and first, so join them
mergedNames <- paste(dldrc$MergedFirst,dldrc$MergedLast, sep = " ")
dldrc <- dldrc %>% mutate(MergedFull=mergedNames)

# read in iLab source data as "df"
# this is for a year of usage

# parse the Customer Lab column using comma
splitNames <- str_split(df$`Customer Lab`, ",")

# the last names are the first element
lastNames <- sapply(splitNames, `[`, 1) # selects the 1st element of each vector in the list

# the rest of the string starts with a space and then the first name, then another space and junk
otherNames <- sapply(splitNames, `[`, 2)
splitOtherNames <- str_split(otherNames, " ")
firstNames <- sapply(splitOtherNames, `[`, 2)
fullNames = paste(firstNames, lastNames, sep = " ")

df_mod <- df %>% mutate(
  `LabLast` = lastNames, 
  `LabFirst` = firstNames, 
  `LabFull` = fullNames,
  .after = `Customer Lab`
)

# Now match up the full names and take only the rows represented in the DLDRC list
# example:
#mylist <- c("C-3PO","R2-D2")
#exampledf <- starwars %>% filter(name %in% mylist)

df_filt <- df_mod %>% filter(LabFull %in% dldrc$MergedFull)

# Categorize usage by service
# This is annoyingly buried in the Charge Name column with a bunch of other stuff
# and efforts to split by the "|" failed because this means OR

confocal_superres <- filter(df_filt, grepl("Red|Yellow|Orange|Aqua|Green|Blue", `Charge Name`))
intravital <- filter(df_filt, grepl("Black", `Charge Name`))
plate <- filter(df_filt, grepl("Cytation",`Charge Name`))
training <- filter(df_filt, grepl("Training", `Usage Type`))

# Summarize each type of usage by lab
conf_sr_summ <- confocal_superres %>% group_by(LabFull) %>% summarize(ConfHours = sum(Quantity), ConfSessions = n())
intrav_summ <- intravital %>% group_by(LabFull) %>% summarize(IntravitalHours = sum(Quantity), IntravitalSessions = n())
plate_summ <- longterm %>% group_by(LabFull) %>% summarize(PlateHours = sum(Quantity), PlateSessions = n())
train_summ <- training %>% group_by(LabFull) %>% summarize(TrainingHours = sum(Quantity), TrainingSessions = n())

# merge all the summaries
merged_summ <- full_join(conf_sr_summ, intrav_summ)
merged_summ <- full_join(merged_summ, plate_summ)
merged_summ <- full_join(merged_summ, train_summ)

# save csv
year <- "2022-23"
write_csv(merged_summ, paste(year, "dldrc summary.csv"))