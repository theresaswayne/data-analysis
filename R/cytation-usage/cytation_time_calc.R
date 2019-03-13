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


startTimes <- logdata %>% 
  filter(grepl("started", Event)) %>%
  select(Start = Date)


endTimes <- logdata %>% 
  filter(grepl("completed", Event)) %>%
  select(End = Date) # the columns need to be renamed before combining


scanTimes <- as.tbl(cbind(startTimes, endTimes)) # combine as tbl (default would be matrix)

scanTimes <- scanTimes %>% 
  mutate(elapsedTime = End - Start) # calculate active time


