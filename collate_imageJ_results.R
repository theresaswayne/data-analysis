# collate_imageJ_results.R

# Theresa Swayne, Columbia University, 2025
# -------- Suggested text for acknowledgement -----------
#   "These studies used the Confocal and Specialized Microscopy Shared Resource 
#   of the Herbert Irving Comprehensive Cancer Center at Columbia University, 
#   funded in part through the NIH/NCI Cancer Center Support Grant P30CA013696."

# --------- About this script ------------
# calculates data from an ImageJ results table
# corrects for background based on an ROI measurement  
#   and calculates cytoplasm (cell - nucleus) mean, IntDen, RawIntDen 
#   from cells and nuclei measured in an ImageJ results table
# Assumptions for input: 
#   Data is from a single 2D image containing one or more cells
#   ImageJ is set to save Row numbers/Column numbers (Edit > Options > Input/Output)
#   1st row is background
#   subsequent rows are nuclei and cell, in order
#   Only the channel of interest is measured
#   At least Label, Mean, IntDen, RawIntDen, Area are included
#   (possible future addition: match cell and nucleus based on Centroid coordinates)
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

# ---- Collect image info ----

# get image name from first row in Label column, 
#   from beginning to the first colon after a dot and 3 characters (file extension)
measName <- data$Label[1]
imageName <- str_match(measName, "^(.*)\\..{3}:")[2] # the second match is the one we want

# get area per pixel, 
#   by dividing the average IntDen by the average RawIntDen
areaPerPixel <- mean(data$IntDen)/mean(data$RawIntDen)

# get number of cells,
#   assuming 2 measurements per cell and 1 row of background
nCells <- (nrow(data) - 1)/2

# get the background mean, 
#   from the first data row
background <- data$Mean[1]

# ---- Organize the data ----

# rename dummy "...1" column (ImageJ does not provide a header)
data <- rename(data, "Measurement" = `...1`)

# sort by column 1 just to make sure we're in order (*may be unnecessary?)
data <- arrange(data, `...1`)

# collect nuclei data
#   collect the nuclei rows: 2, 4, 6, ...
nuclei_rows <- seq(2, nrow(data), by=2)
nuclei_data <- data[nuclei_rows,]

#   add a cell number column to nuclei data
nuclei_data <- mutate(nuclei_data, CellNumber=Measurement/2, .before = Measurement)

#   rename all subsequent data columns
nuclei_renamed <- rename_with(nuclei_data, 
                              ~ paste0("Nuc_", .x),
                                      any_of(c("Measurement", "Label", "Area", 
                                               "Mean", "X", "Y", 
                                               "IntDen", "RawIntDen")))

# collect cell data
#   collect the cell rows: 3, 5, 7...
cells_rows <- seq(3, nrow(data), by=2)
cells_data <- data[cells_rows,]

#   add a cell number column to nuclei data
cells_data <- mutate(cells_data, CellNumber=(Measurement-1)/2, .before = Measurement)

#   rename all subsequent data columns
cells_renamed <- rename_with(cells_data, 
                              ~ paste0("Cell_", .x),
                              any_of(c("Measurement", "Label", "Area", 
                                       "Mean", "X", "Y", 
                                       "IntDen", "RawIntDen")))


# Merge the nuclei and cell data by the cell number, and sort by cell number
data_merged <- full_join(nuclei_renamed, cells_renamed, by=join_by(CellNumber))

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