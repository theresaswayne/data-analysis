##################################################################################
#                           Getting Started with R                               #
#                                                                                #
#                               Intro to Piping                                  #
# Event sponsored by CTSA Biostatistics, Epidemiology and Design Resource (BERD) #
#                                                                                #
##################################################################################       

setwd("C:/Users/jbenn/Documents/R Videos")

library(tidyverse)
library(ggplot2)

#########################################################################
#                          Import Data                                  #
#########################################################################

# Read CSV files: Low and Normal Birthweights

# getwd()             # helps finding the path, given that you saved all the files in the same folder

# Or go to: Session tab -> Set Working Directory and set the path there 

# Read-in dataset
low_birth_all_original <- read.csv("lowbwt_ALL.csv")

# Examples

# Change smoke to a factor variable

low_birth_all_original = low_birth_all_original %>% 
  mutate(
    smoke = factor(smoke, levels = c("0", "1"))
  )

# Find the mean age by smoking status

low_birth_all_original %>% 
  group_by(smoke) %>% 
  summarize(mean_age = mean(age))

# Filter

low_birth_filtered = low_birth_all_original %>% 
  filter(low == 1)

# Create a graph

low_birth_all_original %>% 
  group_by(race) %>% 
  summarize(mean_bwt = mean(bwt)) %>% 
  ggplot(aes(x = race, y = mean_bwt)) + geom_bar(stat = "identity")
