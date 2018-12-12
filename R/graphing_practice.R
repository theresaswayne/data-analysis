# graphing_practice.R

# load packages if not already done
require(ggplot2)
require(here)

# this is using the gas mileage sample data
print(head(mpg))


# Quick plot --------------------------------------------------------------


# quick plot with sensible defaults -- legend, gridlines, shading
# -- column names can be used (no $ needed)
# -- give the dataset, x, y; an additional [continuous] dimension to vary color by;
#     and the symbol

quick <- qplot(data = mpg, x=cty, y=hwy, color = cyl, geom = "point", main = "QPlot")

# to show a plot from a script, run print
print(quick)

# to save a plot, run ggsave after you generate it
# ggsave (here("quickplot.png")) # defaults to last plot generated

# Full ggplot --------------------------------------------------------------

# each line is a full command followed by a +
# assigning a name lets you print to plots panel 

full <- ggplot(data = mpg, aes(x=cty, y=hwy)) + # close paren then add another line with +
    geom_point(aes(color=cyl)) + 
    geom_smooth(method = "lm") + # line
    coord_cartesian()

print(full)

# Add a new layer to a plot with a geom_*() or stat_*() function. 

full_plus <-  full +
  scale_color_gradient() +
  theme_bw() + # no shading
  ggtitle("GGPlot")

print(full_plus)

# using the plot name you can save any plot you've made
ggsave(plot = full, filename = here("full.png")) # format matches extension
