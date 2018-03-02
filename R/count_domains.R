# count_domains.R
# Script to count number of detected domains per protein
# in records downloaded from SGD

# Input: CSV file from SGD with human-readable headers
# Must include Protein systematic name, 
# and all possible fields under protein domains.
# Assumes that the protein contains some domains.

# Output:
# 1. Frequency distribution table and histogram of domains per protein
# 2. Sorted table of proteins by # domains detected (1 row per protein)

# Next steps:
# -- eliminate redundant domains using start and end residues
# -- filter by domains that are involved in protein-protein interactions

# Refinements:
# -- prompt user for file
# -- check for required columns
# -- rename columns in summary to something sensible
# -- format histogram nicely

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

proteins_by_protname <- group_by(proteins, proteins$`Gene.proteins.secondaryIdentifier`)

# Count rows bearing each protein name  --------

domains_per_protein <- summarize(proteins_by_protname, n())

# use backticks around the column name because it has parentheses
inorder <- arrange(domains_per_protein, desc(`n()`))

# Create and save histogram of domains per protein ---------------------------------

outputgraph <- file.path(datapath,"domains_per_prot_redundant.pdf")
pdf(file = outputgraph)

hist(domains_per_protein$`n()`, breaks = 70, col = "blue", main="Domains per protein including redundancies", xlab="domains identified in SGD")

dev.off() # closes pdf output

# Save data table -----------------------------------------------

outputfile <- "proteins_by_number_domains.csv"
write.csv(inorder, file.path(datapath,outputfile))
