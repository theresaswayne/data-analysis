# graphing calculator

require(ggplot2)

# Plot a function without data (must specify range of x-axis)

#f <- function(x) sqrt(x)*10
f <- function(x) sqrt(x*(1-x)/1000)

g <- function(x) x

xMin <- 0
xMax <- 1

base <-
  ggplot() +
  xlim(xMin, xMax)

funGraph <- 
  base + 
  geom_function(fun = f) +
#  geom_function(fun = g) +
  ggtitle("Function")

print(funGraph)

# Generate a data table and plot the data from the table

xvals <- seq(xMin, xMax, by=1)
yvals <- f(xvals)
df <- cbind(x=xvals, y=yvals)

dataGraph <- 
  base + 
  aes(xvals, yvals) + 
  geom_point(shape=1) +
  ggtitle("Data")

print(dataGraph)
