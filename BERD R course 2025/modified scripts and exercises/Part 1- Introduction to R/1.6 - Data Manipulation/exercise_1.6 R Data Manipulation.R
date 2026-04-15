
#################################################################
##           Exercise for 1.6 - Data Manipulation              ##
#################################################################

# Question 1: Load the data set "trashwheel2014.csv" into R, 
# then clean variable names, 
# then filter the the data to include only May, June and July data, and Weight greater than 3
# then remove the first and the last two columns
# then create a variable that indicate Glass Bottle greater than 70 or not.

df <- read.csv("trashwheel2014.csv")

# clean names
require(dplyr)
df_temp <- rename(df, Weight_tons = "Weight..tons.")
df_temp <- rename(df, Weight_tons = "Weight..tons.",
                  Volume_cu_yds = "Volume..cubic.yards.",
                  )
df_clean <- janitor::clean_names(df)  # clean_names = unique and no special chars except _

# filter
df_filt <- df_clean %>% filter(month %in% c("May","June","July") & weight_tons > 3)

# select
ncol(df_filt)

df_sel <- df_filt %>% select(2:3)
last_col <- ncol(df_filt)-2 # seems we have to define this variable, because we can't put an expression in the select operation
df_sel <- df_filt %>% select(2:last_col)

# threshold for glass bottle

df_mut <- mutate(df_sel, high_glass = ifelse(glass_bottles > 70, 1, 0))

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
newdat2 <- filter(newdat1, month %in% c("May","June","July") & weight_tons>=3)

# create dat3 by removing the 1st column and the last two columns of dat2
newdat3 <- select(newdat2, -c(x, x15, x16))

# create a new variable that indicates glass_bottles greater than 70 in dat3 
newdat3 <- mutate(newdat2, bottle_cat = ifelse(glass_bottles>70, 1, 0))




# Another possible solution for Question 1 if you already know how to use piping
trashwheel_dat = read.csv("/Users/tmpuser/Desktop/R mini course/data/trashwheel2014.csv")
trashwheel_dat = df
newdat <- trashwheel_dat %>% 
  janitor::clean_names() %>% 
  filter(month %in% c("May","June","July") & weight_tons>=3) %>% 
  select(-c(x, x15, x16)) %>% 
  mutate(bottle_cat = ifelse(glass_bottles>70, 1, 0))


  

# Want to compare whether newdat3 (from the first solution) and newdat (from the second solution) are the same? 
install.packages("arsenal")  # you only need to run this line once
library(arsenal)
comparedf(newdat3, newdat)

