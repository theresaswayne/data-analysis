
#####################################################################################
#                     Getting Started with R: Data Visualization                    #
#      Sponsored by CTSA Biostatistics, Epidemiology and Design Reource (BERD)      #
#    in collaboration with the Department of Biostatistics, Columbia University.    #
#####################################################################################

# Load required libraries
library(ggplot2) # for the graphs 
library(MASS) # for the data 
library(dplyr) # for data manipulation
library(patchwork) # for arranging graphs

# recall using data()

# load the data
data("birthwt")

# take a look at the help file for ggplot
?ggplot

###############################################################
#                         First Plots                         #
###############################################################

# example: histogram

ggplot(data = birthwt) + geom_histogram(aes(x = bwt)) # notice the warning
ggplot(data = birthwt) + geom_histogram(aes(x = bwt), bins = 25) # you can use "bins = "
ggplot(data = birthwt) + geom_histogram(aes(x = bwt), binwidth = 250) # or "binwidth = " to specify your bins
# Note: the bins/binwidth options go OUTSIDE the aesthetics
# take a look at ?geom_histogram

# example: scatterplot

ggplot(data = birthwt) + geom_point(aes(y = bwt, x = age))

# example: bar chart

ggplot(data = birthwt) + geom_bar(aes(x = race))

# example: box plot

ggplot(data = birthwt) + geom_boxplot(aes(x = race, y = bwt)) # notice the error: this is because race is currently a numeric
ggplot(data = birthwt) + geom_boxplot (aes(x = factor(race), y = bwt)) # use "factor ()" to specify that race should be a factor

# let's go ahead and fix race and smoke to be factor instead of numeric so we don't have that issue again:
# (recall mutate and recode)

birthwt = mutate(birthwt, race=factor(race, levels = c(1,2,3)), smoke = factor(smoke, levels = c(0,1)))

ggplot(data = birthwt) + geom_boxplot(aes(x = race, y = bwt))
