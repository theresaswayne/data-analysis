# graphing_practice.R

# See also -------------

# see https://stackoverflow.com/questions/3541713/how-to-plot-two-histograms-together-in-r (ggplot)
#ggplot(vegLengths, aes(length, fill = veg)) + 
#  geom_histogram(alpha = 0.5, position = 'identity')

#ggplot(iris, aes(x = Sepal.Length, fill = Species)) +
#  geom_histogram(alpha = 0.6, position = "identity")

# Setup --------------

# load packages if not already done
require(ggplot2)
require(here)
require(dplyr)

# using the gas mileage sample data
# print(head(mpg))


# qplot (Quick plot) --------------------------------------------------------------

# Sensible defaults -- legend, gridlines, shading
# -- column names can be used (no $ needed)
# -- give the dataset, x, y; an additional [continuous] dimension to vary color by;
#     and the symbol

# Fig 1 ------
quick <- qplot(data = mpg, x=cty, y=hwy, color = cyl, geom = "point", main = "Fig. 1: Qplot")

# To show a plot while using Run, just say the name
quick # will work with Run but not Source

# To show a plot with Run OR Source, use print
#print(quick)

# To save a plot, run ggsave after you generate it
# ggsave (here("quickplot.png")) # defaults to last plot generated

# Save any plot by name
# ggsave(plot = quick, filename = here("reports", "quick.png")) # format matches extension

# ggplot --------------------------------------------------------------

# Start with basic template from cheatsheet
# Each line is a full command followed by a +

# Assign a name so you can print to the Plots panel, save, or add more features later

# Required elements: data; aes for axes; geom function for type of plot
# Add a new layer to a plot with a geom_*() or stat_*() function. 

# Fig 2 ---------
simple_plot <- ggplot(data = mpg, aes(x=cty, y=hwy)) +
  geom_point() +
  labs(title = "Fig. 2: simple scatter plot")

#print(simple_plot)


# Fig 3 ---------
simple_hist <- ggplot(data = mpg, aes(cty)) + # aes in a histogram is the column you want to plot
  geom_histogram() +
  labs(title = "Fig. 3: simple histogram")

#print(simple_hist)


# Histograms ------
# Fig 4 --------
fancy_plot <-  simple_plot +
  aes(color=cyl) + # vary color by another variable
  scale_color_gradient() +
  theme_bw() + # no shading in background
  ggtitle("Fig. 4: Color varied by Cylinder")

#print(fancy_plot)

# Fig 5 ---------
fancy_hist <- ggplot(data = mpg, aes(cty))  +
  geom_histogram(binwidth = 1, colour = "blue", fill = "blue") +
  ggtitle("Fig. 5: Smaller bins")

#print(fancy_hist)

# Scatter: coordinate systems --------------------------------------------------------------

# Fig 6 ---------
log_plot <- simple_plot +
  scale_y_log10() + # Plot y on log10 scale
  labs(x = "mpg, city", y = "mpg, hwy", title = "Fig. 6: Log Plot") 
#print(log_plot)

# Scatter: point styles --------------------------------------------------------------

# point attributes are alpha, colour[sic], fill, group, shape, size, stroke
# https://ggplot2.tidyverse.org/articles/ggplot2-specs.html
# https://ggplot2.tidyverse.org/reference/geom_point.html
# colours: http://research.stowers.org/mcm/efg/R/Color/Chart/

# Fig 7 ---------
dot_plot <- ggplot(data = mpg, aes(x=cty, y=hwy)) +
  scale_y_log10() + # Plot y on log10 scale  
  geom_point(colour = 28, size = 0.5, alpha = 0.5) + 
  theme_classic() + # no fill
  labs(x = "mpg, city", y = "mpg, hwy", title = "Fig. 7: Point size 0.5 with 0.25 transparency")

#print(dot_plot)

# Scatter: varying point color by another variable -----------

#Fig 8 ---------
# continuous color
iris_plot <- ggplot(iris) + 
  geom_point(aes(x=Sepal.Width, y=Sepal.Length, colour=Petal.Length)) + 
  scale_colour_gradient() +
  labs(title = "Fig. 8: Default (continuous) color coding")
print(iris_plot)

# using https://stackoverflow.com/questions/17713456/easiest-way-to-discretize-continuous-scales-for-ggplot2-color-scales

# Fig 9 -----------
# colors from specified gradient end/middle points
iris_identity <- ggplot(iris) + 
  geom_point(aes(x=Sepal.Width, y=Sepal.Length,
                 colour=bincol(Petal.Length,"blue","yellow","red")), size=4) +
  scale_color_identity("Petal.Length", labels=labels, 
                       breaks=breaks, guide="legend") +
  labs(title = "Fig. 9: Colors created to span a set of specified colors")

iris_identity
# Fig 9 ---------
# based on answers from stackoverflow, adapting to scatter data

mybreaks <- c(0,3,6,Inf) # bins
mylabels <- c("≤ 3", "3 - 6", "> 6", "") # null added at end to avoid warning about labels and breaks being same length

  geom_tile() +
  labs(title = "Fig. 10: Discrete color series created from the Yellow-Green palette")
  labs(title = "Fig. 9: Discrete color series created from the Yellow-Green palette")

print(p2)

# Giving names to the breaks and labels
# Fig 10 --------

p3 <- ggplot(iris) +
  geom_point(aes(x=Sepal.Width, y=Sepal.Length,
               colour=cut(Petal.Length, mybreaks))) +
  theme_classic() +
  scale_colour_brewer("Petal Length", type="seq",palette = "YlGn", labels = mylabels, guide = "legend") +
  labs(title = "Fig. 11: Scatterplot with color change at specified breaks in data")

print(p3)

#TODO: AARRGH THE LEGENDS DISAPPEARED FROM 9 AND 10!!!


