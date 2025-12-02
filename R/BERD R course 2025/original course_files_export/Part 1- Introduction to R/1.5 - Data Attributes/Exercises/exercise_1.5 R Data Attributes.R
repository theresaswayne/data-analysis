
#################################################################
##             Exercise for 1.5 - Data Attributes              ##
#################################################################

# Question 1: Load the data set "trashwheel2014.csv" into R, 
# then get the variable names, dimension, number of row and columns of this dataset.



# Question 2: Check the variable class of each column.




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

# Possible solution for Question 1: 
trashwheel_dat = read.csv("/Users/tmpuser/Desktop/R mini course/data/trashwheel2014.csv")
names(trashwheel_dat)
dim(trashwheel_dat)
nrow(trashwheel_dat)
ncol(trashwheel_dat)



##################################################################
##                          Question 2                          ##
##################################################################

# Possible solution for Question 2: 
str(trashwheel_dat) # Or you can use class() to check one by one
