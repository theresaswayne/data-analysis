# Theresa Swayne, 2019
# read object coordinates from NIS Elements Automated Measurement and convert to multi-point for ND Acquisition

require(tidyverse) # for reading and parsing
require(tcltk) # for file choosing
require(xml2)

# ask user to choose CSV file

objectfile <- tk_choose.files(default = "", caption = "Select the Automated Measurement Results CSV file", multi = FALSE) # file chooser window, with a message

# get the filename and parent directory

dataName <- basename(objectfile) # name of the file without higher levels
parentDir <- dirname(objectfile) # parent of the logfile

# read data, filtering out the footer (field statistics) where most columns are NA

objectdata <- read_csv(objectfile) %>%
  filter(is.na(ObjID) == FALSE)

object_coords <- objectdata %>% 
  select(CentreXabs, CentreYabs)

# save the coordinate columns to a tab-separated text file

outputFile = paste(Sys.Date(), dataName, "_coords.txt") # spaces will be inserted

write_tsv(object_coords,file.path(parentDir, outputFile))

# point_template_file <- tk_choose.files(default = "", caption = "Select the XML template file", multi = FALSE) # file chooser window, with a message
# 
# point_template <- read_xml(point_template_file)

# xml_name(point_template)
# xml_children(x)
# xml_text(x)
# xml_find_all(x, ".//baz")
# 
# h <- read_html("<html><p>Hi <b>!")
# h
# xml_name(h)
# xml_text(h)