# read_merge_findmax.r
# Script for learning purposes
#  -- reads in a folder of csv files (measurements of intensity in slices of a stack) into one data frame
#  -- incorporates the filename in each row
#  -- saves the merged data frame to a file
#  -- for each image, finds the row with the maximum mean fluorescence and writes that to a new data frame
#  -- saves the maxima to a file

require(purrr) # for reduce and map functions
require(readr) # for read_csv
require(dplyr) # for mutate, data_frame
require(tidyr) # for unnest

inputFolder <- "./input/"      # path to folder that holds multiple .csv files
outputFolder <- "./output/"

# read files
# from http://serialmentor.com/blog/2016/6/13/reading-and-combining-many-tidy-data-files-in-R


files <- dir(inputFolder, pattern = "*.csv") # get file names

mergedDataWithNames <- data_frame(filename = files) %>% # create a data frame holding the file names
  mutate(file_contents = 
          map(filename,          # read files into a new data column
          ~ read_csv(file.path(inputFolder, .))))

# produces a list where each element is the data from 1 file
# cat(str(mergedDataWithNames))

# unnest to make the list into a flat file again, 
# but it now has 1 extra column to hold the filename
mergedDataFlat <- unnest(mergedDataWithNames)


# save the data for the slice showing the max value in the Mean column 
# for each image.
# from https://stackoverflow.com/questions/24558328/how-to-select-the-row-with-the-maximum-value-in-each-group

maxes <- mergedDataFlat %>% 
  group_by(filename) %>% 
  top_n(1, Mean)

# write output files
outputFile = "mergedData.csv"
write_csv(mergedDataFlat,file.path(outputFolder, outputFile))

maxOutputFile = "maxData.csv"
write_csv(maxes,file.path(outputFolder, maxOutputFile))

