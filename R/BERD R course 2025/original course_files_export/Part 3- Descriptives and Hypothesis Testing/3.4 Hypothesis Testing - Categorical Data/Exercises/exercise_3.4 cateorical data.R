
#################################################################
##             Exercise for 3.4 - Categorical data             ##
#################################################################

# DISCLAIMER: The exercises below are meant for demonstration of codes, not necessarily the most appropriate statistical practice.


# In this exercise, we will use the R built-in dataset 'airquality'


# Question 1: Is Ozone level (<101 ppb vs. >=101 ppb) associated with wind level (<13 mph vs. >=13 mph)?
# Note: According to the Beaufort Wind Scale, >=13 mph is considered at least moderate breeze.
#       According to Environmental Protection Agency, ozone>70 ppb is considered unhealthy for human health and welfare


# Question 2: Does the association found in Question 1 remain the same after adjusting for temperature and solar radiation?


# Scroll down to view solutions
































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

# Possible solution for Question 1: Is Ozone level (<101 ppb vs. >=101 ppb) associated with wind level (<13 mph vs. >=13 mph)?

# dichotomize wind and ozone
practice_data = practice_data %>%
  mutate(wind_bin = ifelse(wind < 13, "<13mph", ">=13mph"),
         ozone_bin = ifelse(ozone < 70, "<70ppb", ">=70ppb"))

# generate summary statistics for ozone level by wind category
table(practice_data$wind_bin, practice_data$ozone_bin)
table(practice_data$wind_bin, practice_data$ozone_bin) %>% prop.table(1) # row proportions

# Fisher's exact test
fisher.test(table(practice_data$wind_bin, practice_data$ozone_bin))



##################################################################
##                          Question 2                          ##
##################################################################

# Possible solution for Question 2: Does the association found in Question 1 remain significant after adjusting for temperature and solar radiation?

# set the binary outcome levels from character to 0 and 1
# the logistic regression model models over the probability of outcome level 1
practice_data = practice_data %>%
  mutate(ozone01 = ifelse(ozone_bin == "<70ppb", 0, 1)) # set >=70 ppb as 1

# check if the new variable is concordent with the original variable
table(practice_data$ozone01, 
      practice_data$ozone_bin, 
      useNA = "always") # this shows how missing values are processed

# fit a logistic regression model
res <- glm(ozone01 ~ wind_bin + temp + solar_r, 
           data = practice_data, 
           family = binomial(link = "logit"))
summary(res)

# report logistic regression results as odds ratios (OR)
tab = data.frame(
  OR = round(exp(summary(res)$coef[, 1]), 2),
  LL = round(exp(confint(res)[, 1]), 2), # lower limit 95% confidence interval for the OR
  UL = round(exp(confint(res)[, 2]), 2), # upper limit 95% confidence interval for the OR
  p = round(summary(res)$coef[, 4], 3) # p value
)

tab
# interpretation example: 
# the odds of having unhealth ozone level (>=70ppb) in days with high speed wind (>=13mph) is 0.36 times that in days with low speed wind (p=0.607) when adjusting for temperature and solar radiation.
