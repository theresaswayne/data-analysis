# reading data from cytation

# note -- include only the audit trail. No procedure sumamry.


require(readr)

# load data
# TODO: make a file chooser
X20190311_test_imaging_time_protocol_2_190311_165300 <- read_csv("sample-data/20190311 test imaging time protocol 2_190311_165300.txt", 
                                                                 col_types = cols(Comment = col_character(), 
                                                                                  Date = col_datetime(format = "%m/%d/%Y %H:%M:%S %p")), 
                                                                 skip = 2)
# TODO: Find "plate read started" and "plate read successfully completed" (sort into columns for multi-step expts?)

# TODO: subtract these values and report a total for the whole expt
