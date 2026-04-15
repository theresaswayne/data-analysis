##################################################################################
#                Getting Started with R - IMPORTING/EXPORTING                    #
#                                                                                #
# Event sponsored by CTSA Biostatistics, Epidemiology and Design Resource (BERD) #
#  in collaboration with the Department of Biostatistics, Columbia University.   #
##################################################################################   

######################################################################
#                      Working Directory                             #
######################################################################

# To get your working directory

getwd()

# If you want to set the working directory:
# Session -> Set Working Directory -> Choose Directory -> Folder where you saved the data

# Declare path in Mac
# "/Users/username/Desktop/file"

# Declare path in Windows
# "C:/Users/username/Desktop/file"

# If you are having trouble, you can always call "getwd()" and edit the path from there, 
# or use the point and click method.

setwd("C:/Users/Julia Thompson/OneDrive - cumc.columbia.edu/Documents/R Videos")

######################################################################
#                          Import Data                               #
######################################################################

# Read CSV files: Low Birthweights

# Read data set 'bwt_Low.csv'

low_birth = read.csv("bwt_Low.csv")

# Read Excel

library(readxl)

low_birth_excel = read_excel("bwt_Low.xlsx")

# Read R built-in data sets

# Check the list of existing R datasets (from package datasets)
data()

# Load R data 'iris'
data(iris)

iris2 = iris

######################################################################
#                          Export Data                               #
######################################################################

# Export to CSV

write.csv(iris, "iris_data.csv") # with row names
write.csv(iris, "iris_data.csv", row.names = FALSE) # without row names

# Export to Excel

library(openxlsx)

write.xlsx(iris, "iris_data.xlsx")

