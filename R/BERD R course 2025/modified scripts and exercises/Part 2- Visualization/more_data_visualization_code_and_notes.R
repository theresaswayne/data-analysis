# install.packages("readxl")
# install.packages("dplyr")
# install.packages("ggplot2")

# Load the library
library(readxl)  # Read in or output dataset in excel or csv format 
library(dplyr)  # Manipulate the dataset
library(ggplot2) # data visualization

# Read in data 
# Session -- Set Working Directory -- Choose Directory
read.csv("birthwt.csv") 

# Specify a name for the dataset and save it 
birthwt = read.csv("birthwt.csv") 

# Check the type of variable within the dataset one by one
class(birthwt$race)
class(birthwt$smoke)
class(birthwt$bwt)

# Check the type of all variables in the dataset
str(birthwt)

# Modify the type of variables by using "mutate" function

birthwt = birthwt %>% 
  mutate(
    low = as.factor(low), # define categorical variable as a "factor" so R won't treat it as having numerical properties
    race = as.factor(race),
    smoke = as.factor(smoke)
    )
  

###################################################################
###########   EXAMPLES OF COMMON GEOM FUNCTIONS   #################
###################################################################

# Histogram: distribution of baby weights
ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt))

# Another way to put aes() 
ggplot(data = birthwt, aes(x = bwt))+
  geom_histogram()

# Save the plot in current environment for later use (Notice! this doesn't mean saving the plot in local computer)
my_histogram = ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt))  
 

my_histogram # "print" the plot to the viewer



# Bar Chart: number of participants by race
# Vertical bar chart
ggplot(data = birthwt)+
  geom_bar(aes(x = race))

# Horizontal bar chart
ggplot(data = birthwt)+
  geom_bar(aes(y = race))


# Box Plot: compare distribution of babys weights by race
ggplot(data = birthwt, aes(x = race, y = bwt))+
  geom_boxplot()


# Add points in the box plot
ggplot(data = birthwt, aes(x = race , y = bwt))+
  geom_boxplot()+
  geom_point()


ggplot(data = birthwt)+
  geom_boxplot(aes(x = race , y = bwt))+
  geom_point(aes(x = race , y = bwt))





###################################################################
##################   TITLES AND AXIS LABELS   #####################
###################################################################


# Add title and axis labels by using "labs"
ggplot(data = birthwt)+
  geom_boxplot(aes(x = race, y = bwt))+
  labs(
    x = "Race",
    y = "Birth Weight (grams)",
    title = "Birth Weight by Race"
  )

  


###################################################################
##################    CUSTOMIZE YOUR PLOT     #####################
###################################################################



# Changing colors by specifying color

ggplot(data = birthwt)+
    geom_boxplot(aes(x = race, y = bwt), color = "blue", fill = "yellow")+
  labs(
    x = "Race",
    y = "Birth Weight (grams)",
    title = "Birth Weight by Race"
  )
  


# Grouping/Stratification

ggplot(data = birthwt)+
    geom_boxplot(aes(x = race, y = bwt, color = smoke))+
  labs(
    x = "Race",
    y = "Birth Weight (grams)",
    title = "Birth Weight by Race"
  )
  
ggplot(data = birthwt)+
    geom_boxplot(aes(x = race, y = bwt, color = smoke))+ # if you want to use variables in the dataset, always specify it within "aes()"
  labs(
    x = "Race",
    y = "Birth Weight (grams)",
    title = "Birth Weight by Race",
    color = "Smoking Status"
  )
  

###################################################################
###########################   Scatter plot  #######################

ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )


# Change the labels of color

ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )+
  scale_color_discrete(label = c("Non-smoker", "Smoker"))




# Choose your color. Use blue to indicate smoker and yellow for non-smoker
ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )+
  scale_color_discrete(label = c("No", "Yes"))+
  scale_color_manual(values = c("blue", "yellow")) # labels have been overwrite by default setting

# Add label within "scale_color_manual" will address this issue

ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )+
  scale_color_manual(label = c("No", "Yes"),
                     values = c("blue", "yellow"))


# You can also use hex code of color
ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )+
  scale_color_manual(values = c("#F8766D", "#87CEEB"), # You can use google to search hex color code (e.g hex color code for sky blue)
                     label = c("No", "Yes"))


# Change the point size by specifying size
ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke), size = 4)+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )+
  scale_color_manual(values = c("#F8766D", "yellow"),
                     label = c("No", "Yes"))

# Size by group
ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = smoke, size = race))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Smoking Status"
  )+
  scale_color_manual(values = c("#F8766D", "yellow"),
                     label = c("No", "Yes"))


# Emphasize smoking group

ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = race, size = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Race"
  )+
  scale_color_manual(values = c("#F8766D", "yellow", "blue"))

# Choose your size 
ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = race, size = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Race"
  )+
  scale_color_manual(values = c("#F8766D", "yellow", "blue"))+
  scale_size_manual(values = c(2, 4))

# Change the transparency by specifying alpha

ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = race, size = smoke, alpha = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Race"
  )+
  scale_color_manual(values = c("#F8766D", "yellow", "blue"))+
  scale_size_manual(values = c(1.5, 4))+
  scale_alpha_manual(values = c(0.3, 1))


# Change the point type by specifying shape
# 1:circle, 2:triangle, 15: filled square
ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = race), shape = 15, size = 2)+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Race"
  )+
  scale_color_manual(values = c("#F8766D", "yellow", "blue"))

# Using different point type for smoker and non-smoker. Name the legend of shape 

ggplot(data = birthwt)+
  geom_point(aes(x = age, y = bwt, color = race, shape = smoke), size = 3)+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Birth Weight by Mother's Age",
    color = "Race",
    shape = "Smoking Status"  # name the legend of shape
  )+
  scale_color_manual(values = c("#F8766D", "yellow", "blue"))+
  scale_shape_discrete(label = c("No", "Yes")) # specify label for each shape


###################################################################
###########################    Histogram    #######################

ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt))+
  labs(
    x = "Birth Weight (grams)",
    y = "Count"
  )


# Change number of bins or the bin width by specifying bins or binwidth
ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt), bins = 40)+ # specify the number of the bins by "bins = "
  labs(
    x = "Birth Weight (grams)",
    y = "Count"
  )# A guideline of choice of number of bins is to use a number of bins approximately equal to the square root of the total number of data points.



ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt), binwidth = 300)+ # specify the width of bins by "binwidth ="
  labs(
    x = "Birth Weight (grams)",
    y = "Count"
  )


# Change color by specifying color or fill
# Use "color" for outline and "fill" for inside color

ggplot(data = birthwt, aes(x = bwt))+
  geom_histogram(aes(fill = race),color = "black", bins = 25)+
  labs(
    x = "Birth Weight (grams)",
    y = "Count"
  )


###################################################################
###########################    Bar chart    #######################

# Change color by specifying color or fill
# Use "color" for outline and "fill" for inside color
ggplot(data = birthwt, aes(x = race))+
  geom_bar(fill = "lightblue", color = "blue")+
  labs(
    x = "Race",
    y = "Count"
  )

# Change the name of each bar
ggplot(data = birthwt, aes(x = race))+
  geom_bar(fill = "lightblue", color = "blue")+
  labs(
    x = "Race",
    y = "Count"
  )+
  scale_x_discrete(labels = c("1" = "White", "2" = "Black", "3" = "Other")) # Notice ! It won't change the original dataset


# Add text into the bar chart
# 96 white people; 26 black people; 67 others

ggplot(data = birthwt, aes(x = race))+
  geom_bar(fill = "lightblue", color = "blue")+
  geom_text(aes(label = ..count..), stat = "count", vjust = 1.5, colour = "Black")+
  # We needed to tell geom_text() to use the "count" statistic to compute the number of rows for each x value, and then, to use those computed counts as the labels by using the aesthetic mapping aes(label = ..count..)
  labs(
    x = "Race",
    y = "Count"
  )+
  scale_x_discrete(labels = c("1" = "White", "2" = "Black", "3" = "Other"))


###################################################################
###########################    Box plot    ########################

# Change color by specifying color or fill
ggplot(data = birthwt, aes(x = race, y = bwt, color = smoke))+
  geom_boxplot(fill = "grey")+
  labs(
    x = "Race",
    y = "Mother Age (years)",
    title = "Birth Weight by Race and Smoking Status",
    color = "Smoking Status"
  )



###################################################################
###########################    Theme       ########################

# Change theme
# google the ggplot theme
ggplot(data = birthwt, aes(x = race, y = bwt, color = smoke))+
  geom_boxplot()+
  theme_classic()

ggplot(data = birthwt, aes(x = race, y = bwt, color = smoke))+
  geom_boxplot()+
  theme_light()

# Adjust the position of title and axis labels
ggplot(data = birthwt)+
  geom_point(aes(x = bwt, y = age, color = smoke))+
  labs(
    x = "Birth Weight (grams)",
    y = "Mother Age (years)",
    title = "Scatterplot"
  )+
  theme(
    plot.title = element_text(hjust = 0.5),# Left: hjust = 0; center: hjust = 0.5; right: hjust = 1
    axis.title.x = element_text(hjust = 1)
    ) 

# Rotate the x-axis labels 
ggplot(data = birthwt)+
  geom_point(aes(x = bwt, y = age, color = smoke))+
  theme(axis.text.x = element_text(angle = 45))




###################################################################
#######################   SAVE THE PLOT  ##########################
###################################################################


# Using the graphics device in R
pdf("my_plot.pdf")

ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt))

dev.off() 

# Using ggsave

ggplot(data = birthwt)+
  geom_histogram(aes(x = bwt))

ggsave("my_plot2.jpeg", plot = last_plot(), device = "jpeg")


###################################################################
#######################       Layering     ########################
###################################################################


# Add a vertical line at the mean of baby's weight
ggplot(data = birthwt)+ 
  geom_point(aes(x = bwt, y = age))+
  geom_vline(aes(xintercept = mean(bwt)))

# Add a horizontal line at the mean of age
ggplot(data = birthwt)+ 
  geom_point(aes(x = bwt, y = age))+
  geom_hline(aes(yintercept = mean(age)))


# Add annotation into the plot
ggplot(data = birthwt)+ 
  geom_point(aes(x = bwt, y = age))+
  geom_text(x = 3000, y = 40, label = "Mean Birthweight")

###################################################################
#######################     Facet Grid     ########################
###################################################################

# Use facet grid to show different groups

ggplot(data = birthwt)+ 
  geom_point(aes(x = bwt, y = age))+
  facet_grid(rows=vars(smoke))

###################################################################
#######################       Patchwork    ########################
###################################################################

# Arrange separate ggplots into the same graphic

# install.packages("patchwork")

library(patchwork)

# Create a box plot and name it box_plot
box_plot = ggplot(data = birthwt)+
  geom_boxplot(aes(x = race, y = bwt))

# Create a scatter plot and name it scatter_plot
scatter_plot = ggplot(data = birthwt)+
  geom_point(aes(x = bwt, y = age))

# Show box_plot and scatter_plot side by side in one graph
box_plot+scatter_plot
box_plot/scatter_plot




