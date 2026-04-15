
##################################################################
##             Exercise for 3.2 - Continuous outcome            ##
##################################################################

# DISCLAIMER: The exercises below are meant for demonstration of codes, not necessarily the most appropriate statistical practice.

require(tidyverse)
require(arsenal)
require(janitor)

# In this exercise, we will use the R built-in dataset 'airquality'
# Use '?airquality' to check the dataset description
df_orig <- airquality
df <- clean_names(df_orig)

# Question 1: Does ozone level differ by wind level (<13 mph vs. >=13 mph).
# Note: According to the Beaufort Wind Scale, >=13 mph is considered at least moderate breeze.

# Approach: 
# 1. convert Wind to a factor with 2 levels, < 13 and >=13
# 2. determine type of test: test normality of Ozone, and equality of variances
# 3. If normal, do t-test (equal or uneq var as needed); if not, do wilcoxon

dfMod <- df %>% 
  mutate(WindFactor = ifelse(Wind < 13 , 0, 1)) %>%
  mutate(WindFactor = factor(WindFactor,
                      levels = c("0", "1"),
                      labels = c("Low","High")))

str(dfMod)

hist(dfMod$Ozone)
hist(dfMod$Ozone[dfMod$WindFactor=="Low"])
hist(dfMod$Ozone[dfMod$WindFactor=="High"])

qqnorm(dfMod$Ozone)
qqline(dfMod$Ozone)
# data is not normally distributed so we use a wilcoxon test
wilcox.test(Ozone ~ WindFactor, data =dfMod)

# and indeed the medians are quite different
median(dfMod$Ozone[dfMod$WindFactor=="Low"], na.rm = TRUE)
median(dfMod$Ozone[dfMod$WindFactor=="High"], na.rm = TRUE)


# ANSWER: Yes, Ozone is significantly different between days with lower and higher wind

# Question 2: Create descriptive statistics for solar_r, temp, month by wind level defined above.
# Note: Dichotomize month to 5,6 vs 7,8,9

# Approach: 
# 1. Make month into a factor with 2 levels
# 2. Group by wind factor and summarise or use tableby 

dfMod2 <- dfMod %>%
  mutate(MonthFactor = ifelse(Month < 7 , 0, 1)) %>%
             mutate(MonthFactor = factor(MonthFactor,
                                        levels = c("0", "1"),
                                        labels = c("Early","Late")))

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

tab1 <- tableby(Ozone~WindFactor, data = dfMod2, control = my_controls)
summary(tab1, text = T) # this is quite unreadable

# improved answers
require(janitor)
dfGood <- clean_names(df)
dfGood = dfGood %>%
  mutate(wind_bin = ifelse(wind < 13, "<13mph", ">=13mph")) # now a character

# generate summary statistics for ozone level by wind category
dfGood %>%
  group_by(wind_bin) %>% # group the dataset by wind group
  summarise(missing = sum(is.na(ozone)), # number of missing values
            sample_size = sum(!is.na(ozone)), # sample size
            avg = mean(ozone, na.rm = T), # summarize ozone
            std = sd(ozone, na.rm = T), 
            med = median(ozone, na.rm = T), 
            IQR1 = summary(ozone)[2], # 1st quartile
            IQR3 = summary(ozone)[5]) # 3rd quartile


dfGood = dfGood %>%
  mutate(month_bin = ifelse(month < 7, "5/6", "7/8/9"))

# Customize the table
my_controls <- tableby.control(
  total = T,   # If you don't want the summary of the Total (all groups), you can put total=F                   
  test = F,      # Do not display any p-values yet
  numeric.stats = c("Nmiss2", "meansd", "medianq1q3", "range"),   # Choose the summary statistics to be displyed for continuous variables
  cat.stats = c("Nmiss2", "countpct"),   # Choose the summary statistics to be displyed for categorical variables, use countrowpct if need row percent
  stats.labels = list(
    Nmiss2 = "Missing",
    meansd = "Mean (SD)",   # Re-name/re-label the summary statistics to be easier to read from the table
    medianq1q3 = "Median (Q1, Q3)",
    range = "Min - Max",
    countpct = "N (%)"),
  digits = 2) # save 2 digits

# Change variable names/labels
my_labels <- list(solar_r = "Solar Radiation (Langley)", 
                  temp = "Temperature (F)", 
                  month_bin = "Month")

# descriptive table
tab <- tableby(wind_bin ~ solar_r + temp + month_bin, 
               data = dfGood, control = my_controls)
summary(tab, title = "Descriptive Statistics", 
        labelTranslations = my_labels, text = T)

# Question 3: Does the association found in Question 1 remain the same after adjusting for temperature and solar radiation?

# Approach: Do anova using temp and solar
mod<- lm(ozone ~ wind_bin, data = dfGood)
anova(mod)
mod2<- lm(ozone ~ wind_bin + temp + solar_r, data = dfGood)
anova(mod2)# Scroll down to view solutions

par(mfrow = c(2, 2))
plot(mod2)






























###########################################################################
###########################################################################
###                                                                     ###
###                              SOLUTIONS                              ###
###                                                                     ###
###########################################################################
###########################################################################

rm(list = ls())
library(dplyr)
library(janitor)
library(arsenal)

# check data description and re-save it as practice_data
?airquality
practice_data = airquality

# check data summary
summary(practice_data)
practice_data = clean_names(practice_data)

##################################################################
##                          Question 1                          ##
##################################################################

# Possible solution for Question 1: Does ozone level differ by wind level (<13 mph vs. >=13 mph)?

# dichotomize wind
practice_data = practice_data %>%
  mutate(wind_bin = ifelse(wind < 13, "<13mph", ">=13mph"))

# generate summary statistics for ozone level by wind category
practice_data %>%
  group_by(wind_bin) %>% # group the dataset by wind group
  summarise(missing = sum(is.na(ozone)), # number of missing values
            sample_size = sum(!is.na(ozone)), # sample size
            avg = mean(ozone, na.rm = T), # summarize ozone
            std = sd(ozone, na.rm = T), 
            med = median(ozone, na.rm = T), 
            IQR1 = summary(ozone)[2], # 1st quartile
            IQR3 = summary(ozone)[5]) # 3rd quartile

# test for variance
var.test(ozone ~ wind_bin, dfGood) # outcome ~ group
# unequal variance, two-sample t-test
t.test(ozone ~ wind_bin, dfGood, var.equal = F) 

##################################################################
##                          Question 2                          ##
##################################################################

# Possible solution for Question 2: Create descriptive statistics for solar_r, temp, month by wind level defined above.

practice_data = practice_data %>%
  mutate(month_bin = ifelse(month < 7, "5/6", "7/8/9"))

# Customize the table
my_controls <- tableby.control(
  total = T,   # If you don't want the summary of the Total (all groups), you can put total=F                   
  test = F,      # Do not display any p-values yet
  numeric.stats = c("Nmiss2", "meansd", "medianq1q3", "range"),   # Choose the summary statistics to be displyed for continuous variables
  cat.stats = c("Nmiss2", "countpct"),   # Choose the summary statistics to be displyed for categorical variables, use countrowpct if need row percent
  stats.labels = list(
    Nmiss2 = "Missing",
    meansd = "Mean (SD)",   # Re-name/re-label the summary statistics to be easier to read from the table
    medianq1q3 = "Median (Q1, Q3)",
    range = "Min - Max",
    countpct = "N (%)"),
  digits = 2) # save 2 digits

# Change variable names/labels
my_labels <- list(solar_r = "Solar Radiation (Langley)", 
                  temp = "Temperature (F)", 
                  month_bin = "Month")

# descriptive table
tab <- tableby(wind_bin ~ solar_r + temp + month_bin, 
                 data = practice_data, control = my_controls)
summary(tab, title = "Descriptive Statistics", 
        labelTranslations = my_labels, text = T)

##################################################################
##                          Question 3                          ##
##################################################################

# Possible solution for Question 3: Are the association found in question 1 remain the same after adjusting for other variables?

res <- lm(ozone ~ wind_bin + temp + solar_r, data = dfGood)
summary(res)

# Checking model assumptions 
par(mfrow = c(2, 2))
plot(res)

