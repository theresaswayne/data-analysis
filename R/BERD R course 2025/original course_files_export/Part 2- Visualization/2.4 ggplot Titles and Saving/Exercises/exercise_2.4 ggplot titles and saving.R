
#################################################################
##         Exercise for 2.4 - ggplot Titles and Saving         ##
#################################################################

# Question 1: Use the dataset "birthwt" from the MASS package and create boxplots to compare weights of babies between smokers and non-smokers within each race category.
# Choose appropriate title and axis labels.
# Save your plot as a pdf file.




# Challenge: Modify the boxplot from Question 1 so that the boxplots are filled with color by smoking status. 
# Also add labels to the legend and x-axis, before saving it as a png file called my_boxplot.png.
# The variable race is coded as 1 = white, 2 = black, 3 = other.
# Remember, for almost anything you want to do but don't know how to do in R data visualization, Google is your friend!



# Scroll down to view solutions




































###########################################################################
###########################################################################
###                                                                     ###
###                              SOLUTIONS                              ###
###                                                                     ###
###########################################################################
###########################################################################

##################################################################
##                          Question 1                          ##
##################################################################
# Possible solution:
# make sure you have the MASS and ggplot2 packages already installed. If not, remove the hashtag and run the line below to install them
# install.packages("MASS, "ggplot2")
library(MASS) 
library(ggplot2) 

data("birthwt")

birthwt$race = as.factor(birthwt$race)
birthwt$smoke = as.factor(birthwt$smoke)

pdf("my_plot.pdf")

ggplot(data = birthwt)+
  geom_boxplot(aes(x = race, y = bwt, color = smoke))+
  labs(
    x = "Race",
    y = "Birth Weight (grams)",
    title = "Birth Weight by Race and Smoke Status",
    color = "Smoking Status"
  )

dev.off() 



##################################################################
##                           Challenge                          ##
##################################################################
# Possible solution:
ggplot(data = birthwt)+
  geom_boxplot(aes(x = race, y = bwt, fill = smoke))+
  labs(
    x = "Race",
    y = "Birth Weight (grams)",
    title = "Birth Weight by Race and Smoke Status",
    fill = "Smoking Status"
  ) +
  scale_fill_discrete(labels = c("Non-smoker", "Smoker")) +
  scale_x_discrete(labels = c("White", "Black", "Other"))


ggsave("my_boxplot.png",
       plot = last_plot(), # saves the last plot you created
       device = "png",
       path = NULL, # if you want to save your plot somewhere other than your working directory
       width = 4,
       height = 4,
       units = "in",
       dpi = 300,
       limitsize = TRUE
)
