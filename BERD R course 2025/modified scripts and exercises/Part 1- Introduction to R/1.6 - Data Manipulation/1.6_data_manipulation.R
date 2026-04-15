#########################################################################
#               Data Manipulation: library 'dplyr'                      #
#########################################################################

# Load data

setwd("/Users/theresaswayne/Desktop/BERD R course/course_files_export/Part 1- Introduction to R/1.6 - Data Manipulation")

low_birth = read.csv("bwt_Low.csv")

# Install and load library "dplyr"

# install.packages("dplyr")
library(dplyr)

# Select only column/variable age
new_df = select(low_birth, age, id)

# Remove column age 
select(low_birth, -age)

# Keep only rows where 'age' is less than 20 
filter(low_birth, age < 20)

# Keep only rows that contain missing data
filter(low_birth, is.na(age))
# In this data there are no NAs

# Filter rows: select all 25+ yrs old
filter(low_birth, age >= 25)

# Filter rows: select all 25+ yrs old, smokers
filter(low_birth, age >= 25 & smoke==1)

# Ordering data by variable/column 'id'
low_birth <- arrange(low_birth, id)
head(low_birth)

# Arrange in descending order
low_birth <- arrange(low_birth, desc(id))
head(low_birth)

# Order by multiple columns/variables
low_birth <- arrange(low_birth, smoke, desc(age))
head(low_birth)

# Rename variable 'smoke' to 'Smoking_Status' and 
# save this in a new data frame: low_birth_temp

low_birth_temp <- rename(low_birth, Smoking_Status = smoke)
head(low_birth_temp)

# Take the log of 'age'
low_birth_temp <- mutate(low_birth, log_age = log(age))
head(low_birth_temp)

# Centering the data by subtracting the mean from variable 'age'
low_birth_temp <- mutate(low_birth, center_age = age - mean(age))
head(low_birth_temp)

# Use IF-ELSE function to create new age categories
# Cat 1: Age < 25; Cat 2: Age >= 25
low_birth_temp = mutate(low_birth, new_age = ifelse(age < 25 , 0, 1))
head(low_birth_temp)
