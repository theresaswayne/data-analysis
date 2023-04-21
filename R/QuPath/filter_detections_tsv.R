# filter_detections_tsv.R
# R script to filter large QuPath results tables
# To use: Run the script.
# Will be prompted for a detection file

# ---- Setup ----
require(readr)
require(tidyverse)

# ---- Prompt for a detection file ----
# no message will be displayed
detfile <- file.choose()

# Read the data from the file
detData <- read_delim(detfile, 
                      delim = "\t", escape_double = FALSE, 
                      trim_ws = TRUE)

# Cells that are Tumor have Name and Class containing Tumor
detTumor <- detData %>% filter(grepl("Tumor", Name))

fullCount <- count(detData, Name)
tumorCount <- count(detTumor, Name)

# ---- Save new file ----
detName <- basename(detfile) # name of the file without higher levels
parentDir <- dirname(detfile) # parent of the logfile
outputFile = paste(detName, "_tumor.csv") # spaces will be inserted
write_csv(detTumor,file.path(parentDir, outputFile))


