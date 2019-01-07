# test_clusters.R
# Script for testing clustering for domain redundancy

# sample data representing start and end of made-up protein domains
starts <- c(1, 2, 10, 2)
ends <- c(5, 6, 20, 200)

# calculate lengths
lens <- abs(starts - ends)


