
#####################################################################################
#                     Getting Started with R: Data Visualization                    #
#      Sponsored by CTSA Biostatistics, Epidemiology and Design Reource (BERD)      #
#    in collaboration with the Department of Biostatistics, Columbia University.    #
#####################################################################################

# Load required libraries
library(ggplot2) # for the graphs 
library(MASS) # for the data 
library(dplyr) # for data manipulation

# recall using data()

# load the data
data("birthwt")

# take a look at the help file for ggplot
?ggplot

# let's go ahead and fix race and smoke to be factor instead of numeric so we don't have that issue again:
# (recall mutate and recode)

birthwt = mutate(birthwt, race=factor(race, levels = c(1,2,3)), smoke = factor(smoke, levels = c(0,1)))

ggplot(data = birthwt) + geom_boxplot(aes(x = race, y = bwt))

###############################################################
#                     Additional Options                      #
###############################################################


# title and axis labels

ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age)) +
  labs(x="Birth Weight (grams)", 
       y="Mother Age (years)",
       title="Birth weight by Mother's Age",
       caption = "my plot")

# changing colors, size, and shape

ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age), color = "blue", size = 1) +
  labs(x="Birth Weight",
       y="Mother Age (years)",
       title="Birth Weight by Mother's Age")

ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age), color = "blue", size = 3, shape=1) +
  labs(x="Birth Weight",
       y="Mother Age (years)",
       title="Birth Weight by Mother's Age")

# http://www.sthda.com/english/wiki/ggplot2-point-shapes

ggplot(data = birthwt) +
  geom_boxplot(aes(x = race, y = bwt), color = 'grey') +
  labs(x="Birth Weight",
     y="Mother Age (years)",
     title="Birth Weight by Mother's Age")

# grouping/stratification

# without legend labels

ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age, color = smoke))

# adding legend labels, notice we use "color" in all the options

ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age, color = smoke)) +
  labs (x="Birth Weight",
        y="Mother Age (years)",
        title="Birth Weight by Mother's Age",
        color = "Smoking Status") +
  scale_color_discrete(labels = c("No", "Yes"))

# try using "shape" instead

ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age, shape = smoke)) +
  labs(x="Birth Weight",
       y="Mother Age (vears)",
       title="Birth Weight by Mother's Age",
       shape = "Smoking Status") +
  scale_shape_discrete(labels = c("No", "Yes"))

# now with a bar chart, we will use "fill" because we want to fill the bars

ggplot(data = birthwt) +
  geom_bar(aes(x = race, fill = smoke)) +
  labs(x="Race",
       y="Count",
       title="Birth Weight by Race and Smoking Status",
       fill = "Smoking Status") +
  scale_fill_discrete(labels = c("No", "Yes"))

# if you don't want a stacked bar chart, use the "position = dodge" option

ggplot(data = birthwt) +
  geom_bar(aes(x = race, fill = smoke), position = "dodge") +
  labs (x="Race", 
        y="Count",
        title="Birth Weight by Race and Smoking Status",
        fill = "Smoking Status") +
  scale_fill_discrete(labels = c("No", "Yes"))

###############################################################
#                         Saving Plots                        #
###############################################################

# saving plots, option 1

# Customizing the output
pdf("my_plot.pdf",         # File name
    width = 8, height = 7, # width and height in inches
    bg = "White",          # Background color
    colormodel = "cmyk",   # Color model (cmyk is required for most publications)
    paper = "A4")          # Paper size

# Creating a plot
ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age)) +
  labs(x="Birth Weight",
       y="Mother Age (years)",
       title="Birth Weight by Mother's Age",
       color = "Smoking Status") +
  scale_color_discrete(labels = c('No", "Yes"')) +
  geom_smooth(aes(x = bwt, y = age), method = "lm", formula = "y~x", se = FALSE) +
  geom_vline(aes(xintercept = mean(bwt))) +
  geom_text(x = 3000, y = 40, label = "Mean Birthweight", hjust = 0)

# Closing the graphical device
dev.off()

# saving plots, option 2

ggsave("my_plot2.jpeg",
       plot = last_plot(), # can also save your plot before, see below
       device = "jpeg",
       path = NULL, # if you want to save your plot somewhere other than your working directory
       width = 4,
       height = 4,
       units = "in",
       dpi = 300,
       limitsize = TRUE
)

plot_to_export = ggplot(data = birthwt) +
  geom_point(aes(x = bwt, y = age)) +
  labs(x="Birth Weight",
       y="Mother Age (years)",
       title="Birth Weight by Mother's Age",
       color = "Smoking Status") +
  geom_smooth(aes(x = bwt, y = age), method = "lm", formula = "y~x", se = FALSE) +
  geom_vline(aes(xintercept = mean(bwt))) +
  geom_text(x = 3000, y = 40, label = "Mean Birthweight", hjust = 0)

ggsave("my_plot2.jpeg",
       plot = plot_to_export, # can also save your last plot by default
       device = "jpeg",
       path = NULL, # if you want to save your plot somewhere other than your working directory
       width = 4,
       height = 4,
       units = "in",
       dpi = 300,
       limitsize = TRUE
)

