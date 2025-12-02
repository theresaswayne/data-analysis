##################################################################################
#                   Getting Started with R - DATA ATTRIBUTES                     #
#                                                                                #
# Event sponsored by CTSA Biostatistics, Epidemiology and Design Resource (BERD) #
#  in collaboration with the Department of Biostatistics, Columbia University.   #
##################################################################################   

#########################################################################
#                 Examine Data Attributes                               #
#########################################################################

setwd("C:/Users/Julia Thompson/OneDrive - cumc.columbia.edu/Documents/R Videos")

low_birth = read.csv("bwt_Low.csv")

# Variable names
names(low_birth)    

# Data dimension: rows x columns; here: 59 rows and 3 columns
dim(low_birth)

# Number of rows and columns
nrow(low_birth)
ncol(low_birth)

# Head and Tail observations
head(low_birth)
tail(low_birth, n = 10) # default is 6

# Check for missing values
anyNA(low_birth)

# Examine the classes of each column
str(low_birth)

class(low_birth$id) # Examine just one variable using the "$"

# Tabulate variable smoke
table(low_birth$smoke)
