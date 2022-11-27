
# take files containing CDC wastewater data from individual sewersheds
# normalize data to a given date
# plot the data over time


require(tidyverse) # for reading and parsing
require(tcltk) # for file choosing
require(here) # for file choosing


# Input

# See the Sample Data folder for examples.

# ---- User chooses the input folder ----
# LIMITATION: Only wastewater files must be in this folder

inputfolder <- tk_choose.dir(default = "", caption = "OPEN the folder with wastewater data ONLY") # prompt user
inputfiles <- dir(inputfolder, pattern = "*.csv") # Get a list of csv files in the folder
wastewaterFiles <- inputfiles[grepl("sarscov-2_rna_levels", wastefiles)] # check to get only the appropriate type

print("We have the following wastewater data files:")
print (wastewaterFiles)

# ---- Extract the sewershed ID from the filename ----
# this is a group of numbers after "sewershed_"

sewershedIDs <- wastewaterFiles %>% 
  str_match_all(regex("sewershed_(?<ID>[0-9]*)_")) %>%
  sapply("[[", 2)

# ---- Extract the dates and concentrations from each file ----

# Proof of principle: get the data from one sewershed
# Problem: this works, but we want to do it for all of the files automatically
rawDataOne <- read_csv(file.path(wastefolder,wastewaterFiles[1]), 
                       col_types = cols(Date = col_date("%m/%d/%y"), Conc = col_double()), skip = 2) %>% 
  `colnames<-`(c("Date", sewershedIDs[1]))


# Try: Use apply functions to iterate through the file list and make a df for each sewershed
# Problem: We have a list of 2 dfs, each df corresponding to a wastewater file, but we lost the file name info and we want a flat file
rawDataAll <- lapply(list.files(wastefolder,full.names=TRUE), read.csv,skip=2)


# try: map with filenames as in cytation data
# 
# mergedDataWithNames <- tibble(filename = files) %>% # column 1 = file names
#   mutate(file_contents =
#            map(filename,          # column 2 = all the data in the file
#                ~ read_csv(file.path(logfolder, .),
#                           col_types = cols(Comment = col_character(), 
#                                            Date = col_datetime(format = "%m/%d/%Y %H:%M:%S %p")), 
#                           skip = 2)))
# 
# 
# # make the list into a flat file -- each row contains its source filename
# 
# logdata <- unnest(mergedDataWithNames, cols=c(file_contents)) 
# 
# # ---- Find start and end times ----
# 
# # remove lines representing duplication of the same read, 
# # which are present in multiple files
# logdata_unique <- distinct(logdata, Date, .keep_all = TRUE)
# 
# # create a column representing the Experiment base name
# # obtained from the audit trail filename after ignoring the 14 characters in the timestamp
# logdata_unique <- logdata_unique %>% 
#   mutate(Expt = substring(filename, 15))
# 
# # remove unnecessary lines -- keep only the times when reads are started and completed 
# start_endTimes <- logdata_unique %>% 
#   filter(grepl("started|completed", Event))

# try: pull the filename into the list and then extract the id

# fail: https://stackoverflow.com/questions/44742461/r-mutating-along-a-list-of-dataframes
#rawDataWithIDs <- rawDataAll %>% 
#  map(~mutate(., ID = sewershedIDs))

# try: suggestion here https://stackoverflow.com/questions/62928897/r-merge-multiple-dataframes-by-date-without-repeating-dates to merge the data to get a single date column and multiple sewersheds 

