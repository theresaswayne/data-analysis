library(ggplot2)

require(MASS) # database from an S textbook
df <- birthwt # data on birth weight

# anatomy of plot creation
#   data = the dataset to be visualized
#   visuals = the type of plot, aka geom
#   mappings = the variables that are visualized, and possibly their size/color etc., aka aesthetics
# Minimal plot:
# ggplot(data = XXX) + geom_XXX(aes(x=XXX))

# --- geoms ----
# most commmon are geom_boxplot, bar, point, line, histogram
# point = a scatterplot
# bar and histo require only 1 variable; the others require 2

# example of a 1-variable geom: histogram
# bwt is the birth weight in g
# within the geom, but after the aes, we can specify a bin width or number of bins
ggplot(data = df) +
  geom_histogram(aes(x=bwt), binwidth = 500)

ggplot(data = df) +
  geom_histogram(aes(x=bwt), bins = 10)

# example of a 2-variable geom: scatterplot (point)
# age is mother's age in years
# here we have to specify x and y axes
ggplot(data = df) +
  geom_point(aes(y=bwt, x=age))

# a bar is a 1-variable geom, showing (by default) the *count* of values in different categories 
# Similar to a histogram but useful for discrete variables (but not necessary to code as factors)
# race = mother's race  (1 = white, 2 = black, 3 = other)
ggplot(data = df) +
  geom_bar(aes(x=race))

# to get horizontal bars, use the variable "y"
ggplot(data = df) +
  geom_bar(aes(y=race))

# boxplot is a useful 2-variable geom for one discrete, one continuous variable
# the categories (discrete) are referred to as X (on the horiz axis);
# y is used for the numerical values being plotted in the box
ggplot(data = df) +
  geom_boxplot(aes(x=race, y=bwt))

# note that initially, race is not coded as a factor. You may get an errer "Continuous x aesthetic"
# It "worked" for the bar plot but not for the box plot -- you get one big box centered on 2
# to fix, mutate: 

df = mutate(df, race=factor(race, levels = c(1,2,3)), smoke = factor(smoke, levels = c(0,1)))
ggplot(data = df) +
  geom_boxplot(aes(x=race, y=bwt))

?geom_boxplot
# "hinges" (ends of box) = 25th and 75th percentile
# whiskers = roughly 1.5x interquartile range (from 25 to 75) away from the hinge.
# beyond whiskers = outliers
# central line = median

# ---- Making it pretty -----

# labs() are added after the geom 
# x= , y= for axis labels, title=, subtitle=, caption=

# scatterplot with labels added
ggplot(data = df) +
  geom_point(aes(y=bwt, x=age)) +
  labs(x="Mother's age, years",
       y="birth weight, g",
       title = "Birth weight by mother's age")

# colors and sizes for all of the points are within the geom but outside the aesthetic
boo <- ggplot(data = df) +
  geom_point(aes(y=bwt, x=age), 
             color = "blue",
             size = 3) +
  labs(x="Mother's age, years",
       y="birth weight, g",
       title = "Birth weight by mother's age")

# if you add color within the aesthetic, then it will change based on factors
# this is essentially grouping
# for a bar or histo, fill
# for scatter, color or shape
# for box, color
# to customize the legend/color scheme for the grouping variable, add a scale_color after the geom
# there are also continuous color scales 
ggplot(data = df) +
  geom_point(aes(y=bwt, x=age, color = race),
             size = 3) +
  labs(x="Mother's age, years",
       y="birth weight, g",
       title = "Birth weight by mother's age",
       color = "Mother's race") +
  scale_color_discrete(labels = c("White", "Black", "Other"))

ggsave("foo.jpg", plot=last_plot(),device = "jpeg")
ggsave("boo.jpg", plot=boo,device = "jpeg")

  