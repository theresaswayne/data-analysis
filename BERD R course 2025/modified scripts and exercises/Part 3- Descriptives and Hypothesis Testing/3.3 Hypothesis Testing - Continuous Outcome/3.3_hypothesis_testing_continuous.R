##################################################################################
#                           Getting Started with R                               #
#                                                                                #
#                       Hypothesis Testing (Continuous)                          #
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
low_birth_all_original <-birthwt

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

# t.test assumes normality -- it's a parametric test
# to test normality use "prior knowledge, histograms, QQ plots, or normality tests"
# must also be independent observations
# parametric tests compare the means
# t.test reports the mean, the 95% confidence intervals, and p value for mean being different from 26
t.test(low_birth_all$age, mu = 26) 

hist(low_birth_all$age) # histogram -- does it look normally distrib?
qqnorm(low_birth_all$age) # plots your data against a normal distrib; perfect would be a line
qqline(low_birth_all$age) # adds a reference line to the previous plot representing perfect normality
wilcox.test(low_birth_all$age, mu = 26) # nonparametric test testing median

# Two-sample independent t-test
# Is the birthweight significantly different b/w smokers and non-smokers?

# Test the equality of variances

# testing if equal variance
var.test(bwt ~ smoke, data = low_birth_all)


# Two-sample independent t-test with equal variances
# based on the results of the test above (p value for unequal variances is only 0.2)
t.test(bwt ~ smoke, data = low_birth_all, 
       var.equal = TRUE)

# medians are different
wilcox.test(bwt ~ smoke, data =low_birth_all)

# Analysis of Variance (ANOVA)
# Does the birthweight significantly differ by race?
# continuous outcomes, 3 or more groups
# residuals are assumed to be normally distributed 
# (this means the diffs between actual and mean *within each group*)
# and variances are assumed to be equal across groups 
# can also use base R aov for anova
res<- lm(bwt ~ race, data = low_birth_all)
anova(res)

# this tells you that race accounts for some difference but not which one
# follow up with pairwise comparisons and correction for same

# Checking model assumptions 
# Constant variance,
# Normality of residuals,
# Outliers and influential points.
par(mfrow = c(2, 2)) # set plot parameters
plot(res) # plot the linear model we just made
# check q-q plot of residuals, fairly linear

# same plots made by base r
par(mfrow = c(2, 2))
plot(aov(bwt~factor(race), data=low_birth_all))

# alternative if the normality assumption is not met
kruskal.test(bwt ~ race, data = low_birth_all)

