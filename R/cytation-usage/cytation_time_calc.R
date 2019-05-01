# reading data from cytation

# note -- include only the audit trail. No procedure sumamry.

require(tidyverse) # for reading and parsing
require(tcltk) # for file choosing

# load data

#X20190311_test_imaging_time_protocol_2_190311_165300 <- read_csv("sample-data/20190311 test imaging time protocol 2_190311_165300.txt", 
                                                                 # col_types = cols(Comment = col_character(), 
                                                                 #                  Date = col_datetime(format = "%m/%d/%Y %H:%M:%S %p")), 
                                                                 # skip = 2)

logfile <- tk_choose.files(default = "", caption = "Select the Audit Trail file", multi = FALSE) # file chooser window, with a message

logdata <- read_csv(logfile,
                    col_types = cols(Comment = col_character(), 
                                     Date = col_datetime(format = "%m/%d/%Y %H:%M:%S %p")), 
                    skip = 2)


# ---- Find start and end times ----

# add a column for the Read number to help with merging the data later 

startTimes <- logdata %>% 
  filter(grepl("started", Event)) %>%
  select(Start = Date)  %>%
  mutate(Read = row_number())

endTimes <- logdata %>% 
  filter(grepl("completed", Event)) %>%
  select(End = Date)  %>%
  mutate(Read = row_number())


# combine start and end times so each row represents a single read step

scanTimes <- full_join(startTimes, endTimes, by = "Read") # combine using original read number

# ---- Calculate elapsed time and save ----

scanTimes <- scanTimes %>% 
  mutate(elapsedTime = difftime(End, Start, units = "hours")) # convert elapsedTime to hours

# filter out NAs that arise from aborted runs
# calculate active time for whole expt
scanTimeTotal <-  scanTimes %>%
  filter(is.na(elapsedTime) == FALSE) %>%
  summarise(TotalHours = sum(elapsedTime)) 

# save results in the same directory 

logName <- basename(logfile) # name of the file without higher levels

parentDir <- dirname(logfile) # parent of the logfile

outputFile = paste(Sys.Date(), logName, "_total.csv") # spaces will be inserted

write_csv(scanTimeTotal,file.path(parentDir, outputFile))

