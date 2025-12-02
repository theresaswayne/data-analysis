
#################################################################
##      Exercise for 1.4 - Importing and exporting data        ##
#################################################################

# Make sure you have downloaded the 'trashwheel2014.csv' data set from the 1.4 Module Files


# Question 1: Import the data set 'trashwheel2014.csv' and name it 'practice_data'



# Question 2: Export 'practice_data' to an xlsx file and name it 'my_data'



# Scroll down to view solutions































###########################################################################
###########################################################################
###                                                                     ###
###                              SOLUTIONS                              ###
###                                                                     ###
###########################################################################
###########################################################################



##################################################################
##                          Question 1                          ##
##################################################################

# Possible solution for Question 1: Import the data set 'trashwheel2014.csv' and name it 'practice_data'
getwd()  # this is to help you find your working directory
setwd(" ")  # put your working directory inside the quotes
practice_data = read.csv("trashwheel2014.csv")



##################################################################
##                          Question 2                          ##
##################################################################

# Possible solution for Question 2: Export 'practice_data' to an xlsx file and name it 'my_data'
install.packages("openxlsx")  # you only need to run this line if you don't already have the openxlsx package installed
library(openxlsx)

write.xlsx(practice_data, "my_data.xlsx")
