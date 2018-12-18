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
print(head(mpg))


# qplot (Quick plot) --------------------------------------------------------------

# Sensible defaults -- legend, gridlines, shading
# -- column names can be used (no $ needed)
# -- give the dataset, x, y; an additional [continuous] dimension to vary color by;
#     and the symbol

quick <- qplot(data = mpg, x=cty, y=hwy, color = cyl, geom = "point", main = "QPlot")

# to show a plot from a script, run print
print(quick)

# to save a plot, run ggsave after you generate it
# ggsave (here("quickplot.png")) # defaults to last plot generated

# ggplot --------------------------------------------------------------

# Basic template (from cheatsheet)
# Each line is a full command followed by a +
# Assign a name so you can print to the Plots panel, save, or add more features later

# Required elements: data; aes for axes; geom function for type of plot

simple_plot <- ggplot(data = mpg, aes(x=cty, y=hwy)) +
  geom_point()

print(simple_plot)

simple_hist <- ggplot(data = mpg, aes(cty)) + # aes in a histogram is the column you want to plot
  geom_histogram()

print(simple_hist)

# You can save any plot you've made
# ggsave(plot = simple_plot, filename = here("reports", "simple.png")) # format matches extension

# Add a new layer to a plot with a geom_*() or stat_*() function. 

fancy_plot <-  simple_plot +
  aes(color=cyl) + # vary color by another variable
  scale_color_gradient() +
  theme_bw() + # no shading in background
  ggtitle("Color varied by Cylinder")

print(fancy_plot)

fancy_hist <- ggplot(data = mpg, aes(cty))  +
  geom_histogram(binwidth = 1, colour = "blue", fill = "blue") +
  ggtitle("Smaller bins")

print(fancy_hist)

# Scatter plots: varying coordinate systems --------------------------------------------------------------

log_plot <- simple_plot +
  scale_y_log10() + # Plot y on log10 scale
  labs(x = "mpg, city", y = "mpg, hwy", title = "Log Plot") 
print(log_plot)

# Scatter plots: varying point styles --------------------------------------------------------------

# point attributes are alpha, colour[sic], fill, group, shape, size, stroke
# https://ggplot2.tidyverse.org/articles/ggplot2-specs.html
# https://ggplot2.tidyverse.org/reference/geom_point.html

dot_plot <- ggplot(data = mpg, aes(x=cty, y=hwy)) +
  scale_y_log10() + # Plot y on log10 scale  
  geom_point(aes(shape = "circle"), size = 0.1, alpha = 0.5) + 
  labs(x = "mpg, city", y = "mpg, hwy", title = "Circle size 0.1 with 0.25 transparency")

print(dot_plot)
