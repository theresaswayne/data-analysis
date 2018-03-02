# find_redundant_domains.R
# script to detect redundantly identified domains in SGD protein lists

# Input: CSV file from SGD with human-readable headers
# Must include Protein systematic name, 
# and all possible fields under protein domains.
# Assumes that the protein contains some domains.

# Output: CSV file with additional column identifying unique domains per protein

library(dplyr)
library(readr)
library(ggplot2)


# Read file ---------------------------------------------------------------

# datapath <- "/Users/theresa/Documents/home-github/data-analysis/R/count_domains_data"
datapath <- "/Users/confocal/github_theresaswayne/data-analysis/R/count_domains_data"
datafile <- "20180221_SGDproteins_atleast1domain.csv"

# unlike base R's read.csv, readr's read_csv gives a tbl that can be grouped
proteins <- read_csv(file.path(datapath, datafile)) 

# Group by protein name ---------------------------------------------------
proteins_by_protname <- group_by(proteins, proteins$`Gene > Proteins > Systematic Name`)

# Count rows bearing each protein name  --------
domains_per_protein <- summarize(proteins_by_protname, n())


# Plot start vs length ----------------------------------------------------


# mutate dataset to add domain column -------------------------------------

# Calculate distance between each point and neighbors ---------------------

# Try clustering ----------------------------------------------------------



