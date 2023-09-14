# summarize_imaris_volume.R
# R script to summarize Imaris batch result files by image name
# To use: Source the script.
# Will be prompted for a file

# ---- Setup ----
require(tidyverse)
require(readr)
require(stringr)

# ---- Prompt for an object file ----
# no message will be displayed
objectFile <- file.choose()

# Read the data from the file
objectData <- read_csv(objectFile,
                       col_types = cols(...12 = col_skip()), 
                       skip = 3,
                       locale = locale())

sums <- objectData %>% 
  group_by(`Original Image Name`) %>% 
  summarise(nObjects = n(),
            SumVolume = sum(Volume))


# ---- Save new file ----
objectName <- str_sub(basename(objectFile), 1, -5) # name of the file without higher levels or extension
parentDir <- dirname(objectFile) # parent of the logfile
outputFile = paste(objectName, "_summary.csv") # spaces will be inserted
write_csv(sums,file.path(parentDir, outputFile))

