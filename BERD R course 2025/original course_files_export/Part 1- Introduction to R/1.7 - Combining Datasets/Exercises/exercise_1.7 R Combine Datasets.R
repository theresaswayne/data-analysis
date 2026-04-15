
#################################################################
##             Exercise for 1.7 - Combine Datasets             ##
#################################################################

# Question 1: Load "trashwheel2014.csv" into R, 
# clean the variable names, select only dumpster and month
# and subset the data from May and and from June into two separate dataframes. 



# Question 2: Stack the two dataframes for Question 1 together. 



# Question 3: Run the code below to get the simulated data, 
# and join it with the stacked dataframe in Question 2, making sure to keep all observations from May and June.
simul_dat <- data.frame(dumpster = 1:5,
                        combined_value = 100:104)





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

# A possible solution for Question 1:
dat = read.csv("/Users/tmpuser/Desktop/R mini course/data/trashwheel2014.csv")
dat1 = clean_names(dat)
dat2 = select(dat1, c(dumpster, month))
may_dat = filter(dat2, month=="May")
june_dat = filter(dat2, month=="June")



# Another possible solution for Question 1 using piping: 
trashwheel_dat = read.csv("/Users/tmpuser/Desktop/R mini course/data/trashwheel2014.csv") %>% 
  janitor::clean_names() %>% select(dumpster, month)
may_dat = trashwheel_dat %>% filter(month=="May")
june_dat = trashwheel_dat %>% filter(month=="June")




##################################################################
##                          Question 2                          ##
##################################################################

# Possible solution for Question 2: 
# There should be 17 observations total: 8 from May and 9 from June
stacked_dat = rbind(may_dat,june_dat)




##################################################################
##                          Question 3                          ##
##################################################################

# Possible solution for Question 3: 
# There should be 17 observations total, but 12 observations will show NA for the variable combined_value 
# since only dumpsters 1 through 5 have an observation for combined value
merged_dat1 = left_join(stacked_dat, simul_dat, by = "dumpster")



# Another possible solution for Question 3 using piping:
merged_dat2 <- stacked_dat %>% 
  left_join(simul_dat,by = "dumpster")



# Want to compare whether merged_dat1 (from the first possible solution) and merged_dat2 (from the second possible solution) are the same? 
install.packages("arsenal")  # you only need to run this line once
library(arsenal)
comparedf(merged_dat1, merged_dat2)


