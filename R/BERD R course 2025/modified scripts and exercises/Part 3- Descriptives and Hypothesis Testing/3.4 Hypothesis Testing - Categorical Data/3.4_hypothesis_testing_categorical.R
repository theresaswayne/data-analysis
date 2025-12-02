##################################################################################
#                           Getting Started with R                               #
#                                                                                #
#                      Hypothesis Testing (Categorical)                          #
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

#########################################################################
#                       Hypothesis Testing                              #
#########################################################################


# Chi-Squared test of Independence
# Is there an association b/w smoking and low birthweight?
# correct = F if you have large sample size

# this is a table showing that 25% of nonsmoking moms but 40% of smoking moms had low bwt babies
low_birth_all %>%
  tabyl(smoke, low, show_missing_levels = FALSE) %>%
  #adorn_totals("col") %>%                                    # Unselect this if you want col percentages
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 1) %>%
  adorn_ns %>%
  adorn_title

chisq.test(low_birth_all$smoke, low_birth_all$low, correct = F)


# Fisher's Exact Test # for < 5 values per cell
low_birth_all %>%
  tabyl(ht, low, show_missing_levels = FALSE) %>%
  #adorn_totals("col") %>%                                    # Unselect this if you want col percentages
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 1) %>%
  adorn_ns %>%
  adorn_title

# get a warning if using chisq.test
chisq.test(low_birth_all$ht, low_birth_all$low)

# need to use Fisher's exact test
fisher.test(low_birth_all$ht, low_birth_all$low)
