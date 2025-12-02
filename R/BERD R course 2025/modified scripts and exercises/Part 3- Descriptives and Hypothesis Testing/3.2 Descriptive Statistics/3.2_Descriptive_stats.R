##################################################################################
#                           Getting Started with R                               #
#                                                                                #
#                           Descriptive Statistics                               #
# Event sponsored by CTSA Biostatistics, Epidemiology and Design Resource (BERD) #
#                                                                                #
##################################################################################       

#setwd("C:/Users/jbenn/Documents/R Videos")

library(arsenal)                        # Use for function tableby()
library(dplyr)
library(janitor)                        # Use for function tabyl()
library(skimr)
require(MASS)

#########################################################################
#                          Import Data                                  #
#########################################################################

# Read CSV files: Low and Normal Birthweights

# getwd()             # helps finding the path, given that you saved all the files in the same folder

# Or go to: Session tab -> Set Working Directory and set the path there 

# Read-in dataset
#low_birth_all_original <- read.csv("lowbwt_ALL.csv")
low_birth_all_original <- birthwt

# check data type for all variables
str(low_birth_all_original)

# change types of data

low_birth_all = low_birth_all_original %>%
  mutate(
    low = factor(low,
                 levels = c("0", "1"),
                 labels = c("No","Yes")),
    race = factor(race),
    smoke = factor(smoke,
                   levels = c("0", "1"),
                   labels = c("No","Yes")),
    ht = factor(ht,
                levels = c("0", "1"),
                labels = c("No","Yes")),
    ui = factor(ui)
  )

str(low_birth_all)

# check data
# this produces a count (kind of like summarise with n)
table(low_birth_all$low) # gives the count of "no" and "yes"
table(low_birth_all_original$low) # gives the count of "0" and "1"

# "table" with 2 vectors of factors gives a 2x2 contingency table with counts of each possible combination of factor levels
# this can be used to check mutated data because all the values should cluster in the "corners" -- there should be half zeroes
# if some of the data was mis-coded (1 vs 0 or multiple levels) you'd get values in all cells

table(low_birth_all$low, low_birth_all_original$low)   
table(low_birth_all$smoke, low_birth_all_original$smoke)
table(low_birth_all$ht, low_birth_all_original$ht)

#########################################################################
#         Descriptive Statistics: Continuous Variables                  #
#########################################################################

# try function (skim) from library 'skimr' 
# gives an extensive summary with missing, mean, sd, quartiles, histo in the console
skim(low_birth_all)

# check distribution of continuous variable
hist(low_birth_all$age)

# functions to get individual summary statistics
mean(low_birth_all$age)                               # Mean
median(low_birth_all$age)                             # Median
sd(low_birth_all$age)                                 # Standard Deviation
range(low_birth_all$age)                              # range
quantile(low_birth_all$age)                           # Min, 25ht, 50th, 75th, Max
quantile(low_birth_all$age, c(0.10, 0.30, 0.60))        # specify specific quantiles

# A more condensed way to obtain summary statistics
# quartiles and min-max only
summary(low_birth_all$age)

#########################################################################
#         Descriptive Statistics: Categorical Variables                 #
#########################################################################

# Two-way table
tbl <- table(low_birth_all$smoke, low_birth_all$race) # counts
prop.table(tbl, 1)                        		                # Row proportions
prop.table(tbl, 2)                                            # Column proportions

# 3-way cross-tabulation
# 2 tables of smoke vs race, one for each level of ht
xtabs(~ race + smoke + ht, data = low_birth_all)


#################################################################
##                           Table 1                           ##
#################################################################

# Use function tableby() from library 'arsenal' to create a summary table (called Table 1 in publications)
# Use continuous and categorical variables

# First table
tab1 <- tableby( ~ age + bwt + race, data = low_birth_all)
summary(tab1, text = T)

# Customize the table
my_controls <- tableby.control(
  total = T,   # If you don't want the summary of the Total (all groups), you can put total=F                   
  test = F,      # Do not display any p-values yet
  numeric.stats = c("Nmiss2", "meansd", "medianq1q3", "range"),   # Choose the summary statistics to be displayed for continuous variables
  cat.stats = c("Nmiss2", "countpct"),   # Choose the summary statistics to be displayed for categorical variables
  stats.labels = list(
    Nmiss2 = "Missing",
    meansd = "Mean (SD)",   # Re-name/re-label the summary statistics to be easier to read from the table
    medianq1q3 = "Median (Q1, Q3)",
    range = "Min - Max",
    countpct = "N (%)"))

# Change variable names/labels
my_labels <- list(age = "Age(yrs)", bwt = "Birthweight(g)", race = "Race")

# Second table
# use the controls you set previously
tab2 <- tableby( ~ age + bwt + race, 
                 data = low_birth_all, control = my_controls)
summary(tab2, title = "Descriptive Statistics: Lowbirth Data", 
        labelTranslations = my_labels, text = T)

# Tabulation by smoking status (note this comes before the tilde in the function call)
tab3 <- tableby(smoke ~ age + bwt + race, 
                data = low_birth_all, control=my_controls)
summary(tab3, title = "Descriptive Statistics: Lowbirth Data by Smoking Status", 
        labelTranslations = my_labels, text = T)



