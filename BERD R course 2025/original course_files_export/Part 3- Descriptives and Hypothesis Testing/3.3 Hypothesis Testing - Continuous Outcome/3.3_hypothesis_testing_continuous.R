##################################################################################
#                           Getting Started with R                               #
#                                                                                #
#                       Hypothesis Testing (Continuous)                          #
# Event sponsored by CTSA Biostatistics, Epidemiology and Design Resource (BERD) #
#                                                                                #
##################################################################################       

setwd("C:/Users/jbenn/Documents/R Videos")

library(arsenal)                        # Use for function tableby()
library(dplyr)
library(janitor)                        # Use for function tabyl()
library(skimr)

#########################################################################
#                          Import Data                                  #
#########################################################################

# Read CSV files: Low and Normal Birthweights

# getwd()             # helps finding the path, given that you saved all the files in the same folder

# Or go to: Session tab -> Set Working Directory and set the path there 

# Read-in dataset
low_birth_all_original <- read.csv("lowbwt_ALL.csv")

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
table(low_birth_all$low, low_birth_all_original$low)
table(low_birth_all$smoke, low_birth_all_original$smoke)
table(low_birth_all$ht, low_birth_all_original$ht)

#########################################################################
#                       Hypothesis Testing                              #
#########################################################################

# One-sample t-test
# Is the true mean age different than 26?
# Use alpha=0.05

t.test(low_birth_all$age, mu = 26)

hist(low_birth_all$age)
qqnorm(low_birth_all$age)

wilcox.test(low_birth_all$age, mu = 26)

# Two-sample independent t-test
# Is the birthweight significantly different b/w smokers and non-smokers?

# Test the equality of variances

# testing if equal variance
var.test(bwt ~ smoke, data = low_birth_all)


# Two-sample independent t-test with equal variances
# based on the test above.  
t.test(bwt ~ smoke, data = low_birth_all, 
       var.equal = TRUE)

wilcox.test(bwt ~ smoke, data =low_birth_all)

# Analysis of Variance (ANOVA)
# Does the birthweight significantly differ by race?

res<- lm(bwt ~ race, data = low_birth_all)
anova(res)

# Checking model assumptions 
# Constant variance,
# Normality of residuals,
# Outliers and influential points.
par(mfrow = c(2, 2))
plot(res)

par(mfrow = c(2, 2))
plot(aov(bwt~factor(race), data=low_birth_all))

kruskal.test(bwt ~ race, data = low_birth_all)

