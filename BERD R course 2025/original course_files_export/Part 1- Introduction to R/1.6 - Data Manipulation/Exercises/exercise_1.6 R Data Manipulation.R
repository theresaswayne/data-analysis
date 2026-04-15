
#################################################################
##           Exercise for 1.6 - Data Manipulation              ##
#################################################################

# Question 1: Load the data set "trashwheel2014.csv" into R, 
# then clean variable names, 
# then filter the the data to include only May, June and July data, and Weight greater than 3
# then remove the first and the last two columns
# then create a variable that indicate Glass Bottle greater than 70 or not.




# Scroll down to view solutions


































###########################################################################
###########################################################################
###                                                                     ###
###                              SOLUTIONS                              ###
###                                                                     ###
###########################################################################
###########################################################################


# make sure that both dplyr and janitor packages are installed
# install.packages("dplyr", "janitor")
library(dplyr)
library(janitor)


##################################################################
##                          Question 1                          ##
##################################################################

# Possible solution for Question 1: 
trashwheel_dat = read.csv("/Users/tmpuser/Desktop/R mini course/data/trashwheel2014.csv")

# clean the variable names from trashwheel_dat and save a new data set called dat1
newdat1 <- janitor::clean_names(trashwheel_dat) 

# create a new data set called dat2 by subsetting dat1 to only include the months of May, June, and July, and weights greater or equal to 3 tons
newdat2 <- filter(dat1, month %in% c("May","June","July") & weight_tons>=3)

# create dat3 by removing the 1st column and the last two columns of dat2
newdat3 <- select(dat2, -c(x, x15, x16))

# create a new variable that indicates glass_bottles greater than 70 in dat3 
newdat3 <- mutate(dat3, bottle_cat = ifelse(glass_bottles>70, 1, 0))




# Another possible solution for Question 1 if you already know how to use piping
trashwheel_dat = read.csv("/Users/tmpuser/Desktop/R mini course/data/trashwheel2014.csv")

newdat <- trashwheel_dat %>% 
  janitor::clean_names() %>% 
  filter(month %in% c("May","June","July") & weight_tons>=3) %>% 
  select(-c(x, x15, x16)) %>% 
  mutate(bottle_cat = ifelse(glass_bottles>70, 1, 0))


  

# Want to compare whether newdat3 (from the first solution) and newdat (from the second solution) are the same? 
install.packages("arsenal")  # you only need to run this line once
library(arsenal)
comparedf(newdat3, newdat)

