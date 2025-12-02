##################################################################################
#                   Getting Started with R - THE BASICS                          #
#                                                                                #
# Event sponsored by CTSA Biostatistics, Epidemiology and Design Resource (BERD) #
#  in collaboration with the Department of Biostatistics, Columbia University.   #
##################################################################################   

# Syntax and Assignment

# comments start with a "#"

3+2

3+2 ; 4+6 # commands can go on the same line separated by ";"

a = 3+2

b <- 7

A + 2 # R is case sensitive

a + 2 

c = a + 2

a = a + 2

# Loading data is in another video

read.csv("bwt_Low.csv")

low_birth <- read.csv("bwt_Low.csv")

birth2 = low_birth

# Operators

a < b

is.na(a)

log(a)

log_a = log(a)

# Errors

library(dplyt)

library(dplyr)

i = c(2, 1, NA, 4, NA)

is.na(i)==2

is.na(i==2)

