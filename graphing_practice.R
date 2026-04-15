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
require(RColorBrewer)

# using the gas mileage sample data
# print(head(mpg))


# qplot (Quick plot) --------------------------------------------------------------

# Sensible defaults -- legend, gridlines, shading
# -- column names can be used (no $ needed)
# -- give the dataset, x, y; an additional [continuous] dimension to vary color by;
#     and the symbol

# Fig 1 ------
quick <- qplot(data = mpg, x=cty, y=hwy, color = cyl, geom = "point", main = "Fig. 1: Qplot")

# to show a plot from a script, just say the name
quick

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

simple_plot


# Fig 3 ---------
simple_hist <- ggplot(data = mpg, aes(cty)) + # aes in a histogram is the column you want to plot
  geom_histogram() +
  labs(title = "Fig. 3: simple histogram")

simple_hist


# Histograms ------
# Fig 4 --------
fancy_plot <-  simple_plot +
  aes(color=cyl) + # vary color by another variable
  scale_color_gradient() +
  theme_bw() + # no shading in background
  ggtitle("Fig. 4: Color varied by Cylinder")

fancy_plot

# Fig 5 ---------
fancy_hist <- ggplot(data = mpg, aes(cty))  +
  geom_histogram(binwidth = 1, colour = "blue", fill = "blue") +
  ggtitle("Fig. 5: Smaller bins")

fancy_hist

# Scatter: coordinate systems --------------------------------------------------------------

# Fig 6 ---------
log_plot <- simple_plot +
  scale_y_log10() + # Plot y on log10 scale
  labs(x = "mpg, city", y = "mpg, hwy", title = "Fig. 6: Log Plot") 
print(log_plot)

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

print(dot_plot)

# Scatter: varying point color by another variable -----------

#Fig 8 ---------
# continuous color
iris_plot <- ggplot(iris) + 
  geom_point(aes(x=Sepal.Width, y=Sepal.Length, colour=Petal.Length)) + 
  scale_colour_gradient() +
  labs(title = "Fig. 8: Default (continuous) color coding")
print(iris_plot)


# Fig 9 ---------
# using ideas from https://stackoverflow.com/questions/17713456/easiest-way-to-discretize-continuous-scales-for-ggplot2-color-scales
p2<- ggplot(iris, aes(x=Sepal.Width,y=Sepal.Length,fill=cut(Petal.Length, c(0,3,6,Inf)))) +
  geom_tile() +
  scale_fill_brewer(type="seq",palette = "YlGn") + # colors based on a yellow-green palette
  guides(fill=guide_legend(title="Petal Length")) +
  labs(title = "Fig. 9: Tile plot with discrete color series created from the Yellow-Green palette")

print(p2)

# Fig 10 --------
# Adapting to scatter plot, and giving names to the intervals, for use in the legend
# For a scatter plot you have to use scale_colour..., rather than scale_fill_...

mybreaks <- c(0,3,6,Inf) # bins
mylabels <- c("≤ 3", "3 - 6", "> 6") 

p3 <- ggplot(iris) +
  geom_point(aes(x=Sepal.Width, y=Sepal.Length,
               colour=cut(Petal.Length, mybreaks))) +
  theme_classic() +
  scale_colour_brewer("Petal Length", type="seq",palette = "YlGn", labels = mylabels, guide = "legend") +
  labs(title = "Fig. 10: Scatterplot with color change at specified breaks in data")

print(p3)


# Color palettes ----------
## create a sequential palette for usage and show colors
mypalette<-brewer.pal(7,"Greens")
image(1:7,1,as.matrix(1:7),col=mypalette,xlab="Greens (sequential)",
      ylab="",xaxt="n",yaxt="n",bty="n")
## display a divergent palette
display.brewer.pal(7,"BrBG")
## display a qualitative palette
display.brewer.pal(7,"Accent")
## display a palettes simultanoeusly
#display.brewer.all(n=10, exact.n=FALSE)
#display.brewer.all()
display.brewer.all(type="div")
display.brewer.all(type="seq")
display.brewer.all(type="qual") 
display.brewer.all(n=5,type="div",exact.n=TRUE)
display.brewer.all(colorblindFriendly=TRUE)
print(brewer.pal.info)
print(brewer.pal.info["Blues",])
print(brewer.pal.info["Blues",]$maxcolors)


