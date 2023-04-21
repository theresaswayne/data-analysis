# filter_detections_csv.R
# R script to filter large QuPath results tables
# To use: Run the script.
# Will be prompted for a detection file

# ---- Setup ----
require(readr)
require(tidyverse)
require(stringr)

# ---- Prompt for a detection file ----
# no message will be displayed
detfile <- file.choose()

# Read the data from the file
#detData <- read_delim(detfile,
#                      delim = ";", escape_double = FALSE, locale = locale())

detData <- read_csv(detfile,
                      locale = locale())

# Cells that are Tumor have Name and Class containing Tumor
detTumor <- detData %>% filter(grepl("Tumor", Name))

fullCount <- count(detData, Name)
tumorCount <- count(detTumor, Name)

# ---- Save new file ----
detName <- str_sub(basename(detfile), 1, -5) # name of the file without higher levels or extension
parentDir <- dirname(detfile) # parent of the logfile
outputFile = paste(detName, "_tumor.csv") # spaces will be inserted
write_csv(detTumor,file.path(parentDir, outputFile))


