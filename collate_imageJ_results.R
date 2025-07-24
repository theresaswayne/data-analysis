# calculations.R

# calculate cytoplasm (cell - nucleus) mean, IntDen, RawIntDen from cells and nuclei measured in ImageJ
# Assumptions for input: 
#   Data is from a single image
#   1st row is background
#   subsequent rows are nuclei and cell, in order
#   Only the FUS channel is measured

# Output: Each row = 1 cell; intensity data is based on FUS channel (3) 
# Output columns:
#   Image name, Cell number, 
#   Nucleus area, Nucleus mean, Nucleus IntDen, Nucleus RawIntden
#   Cell area/mean/intden/rawintden
#   Cytoplasm area/mean/intden/rawintden
#   Background-corrected mean, intden, rawintden for each compartment
#   cytoplasm/nucleus ratio (background corrected) for mean, intden, rawintden
#   cytoplasm/cell ratio (background corrected) for mean, intden, rawintden

# ---- Setup and load data ----

require(tidyverse) # for data processing
require(stringr) # for string harvesting

# prompt for a data file (no message will be displayed)
selectedFile <- file.choose()

# read the file
data <- read_csv(selectedFile)


# ---- Organize the data ----

# Gather info about the image and data table  
#   get image name from Label column
#   get number of cells by dividing (nrows-1)/2
#   get area per pixel by dividing the avg ID by the avg RawID (confirm!)

# Collect the background mean from the first data row
background <- data$Mean[1]

# Sort by column 1 just to make sure we're in order

# Assuming 'df' is your data frame
# df[seq(2, nrow(df), by = 2), ] # Selects even-numbered rows (2nd, 4th, etc.)
# df[seq(1, nrow(df), by = 2), ] # Selects odd-numbered rows (1st, 3rd, etc.)

# Collect the nuclei rows: 2, 4, 6, ...
# add a cell number column
# rename data columns Nuc_Mean, etc

# Collect the cell rows: 3, 5, 7...
# add a cell number column
# rename data columns Cell_Mean, etc

# Merge the nuclei and cell data by the cell number, and sort by cell number

# ---- Calculate results ----

# Do background correction on nuclei and cells

#   For Mean, subtract background value
#   For IntDens, subtract background * area (um2)
#   For RawIntDens, calculate area (pixels) = rawID/ID * area; then subtract background * area (pixels)

#   Output cols Corr_Nuc_Mean, etc

# Calculate cytoplasm data
  # Cyto_Area_um = Cell_Area - Nuc_Area (um)
  # Cyto_Area_Pixels = Cyto_Area_um * area_per_pixel
  # Corr_Cyto_RawIntDen = Corr_Cell_RawIntDen - Corr_Nuc_RawIntDen
  # Corr_Cyto_IntDen = Corr_Cyto_RawIntDen * area_per_pixel
  # Corr_Cyto_Mean = Corr_Cyto_IntDen/Cyto_Area_um (confirm as Corr_Cyto_RawIntDen/Cyto_Area_Pixels)

# Calculate ratios
#   cytoplasm/nucleus ratio (background corrected) for mean, intden, rawintden
#   cytoplasm/cell ratio (background corrected) for mean, intden, rawintden
# Corr_Cyto/Nuc_Mean,etc
# Corr_Cyto/Cell_Mean, etc

# ---- Output results ----

outputFolder <- dirname(selectedFile) # parent of the input folder
# generate filename from image name
# outputFile = paste(basename(inputFolder), " merged", finalText, sep = "")
# write CSV file
# write_csv(mergedDataFlat,file.path(outputFolder, outputFile))