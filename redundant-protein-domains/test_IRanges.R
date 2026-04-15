# test_IRanges.R
# script to play with Range objects and related methods
# for possible use with find_redundant_domains.R

library(IRanges)
library(S4Vectors)
library(stats4)

# sample data representing start and end of made-up protein domains
starts <- c(10, 20, 100, 20)
ends <- c(50, 60, 200, 2000)

x <- IRanges(start=starts, end=ends)

que <- x[1]

subj <- x[2:4]

ove <- findOverlaps(x, x)

nea <- nearest(x, x)

d2nea <- distanceToNearest(x, x, select = "arbitrary")

dista <- distance(x, x)


