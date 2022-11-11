# graphing calculator

# To plot functions without data, specify range of x-axis
base <-
  ggplot() +
  xlim(-20, 20)

f <- function(x) 0.5*exp(-abs(x))
ben <- function(x) (sqrt(x^2 + x - 12) + 2)

mygraph <- base + geom_function(fun = f)
bengraph <- base + geom_function(fun = ben)
bengraph2 <- base + stat_function(fun = ben)

print(bengraph)

# get a data table
xvals <- seq(-20, +20, by=0.1)
yvals <- ben(xvals)
df <- cbind(x=xvals, y=yvals)

datagraph <- base + aes(xvals, yvals) + geom_point(shape=2)

