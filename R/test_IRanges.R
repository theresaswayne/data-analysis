# test_IRanges.R
# script to play with Range objects and related methods
# for possible use with find_redundant_domains.R

library(IRanges)

# sample data representing start and end of made-up protein domains
starts <- c(1, 2, 10, 2)
ends <- c(5, 6, 20, 200)

x <- IRanges(start=starts, end=ends)

que <- x[1]

subj <- x[2:4]

ove <- findOverlaps(que, subj)

nea <- nearest(x = que, subject = subj)

