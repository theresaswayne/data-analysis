# find_redundant_domains.R
# script to detect redundantly identified domains in SGD protein lists

# Input: CSV file from SGD with raw headers
# Must include Protein systematic name (secondary identifier), 
# and all possible fields under protein domains.
# Assumes that the protein contains some domains.

# Output: CSV file with additional column identifying unique domains per protein

library(dplyr)
library(readr)
library(ggplot2)

# Read file ---------------------------------------------------------------

# datapath <- "/Users/theresa/Documents/home-github/data-analysis/R/count_domains_data"
datapath <- "/Users/confocal/github_theresaswayne/data-analysis/R/count_domains_data"
datafile <- "20180302_SGDproteins_atleast1domain.csv"

# unlike base R's read.csv, readr's read_csv gives a tbl that can be grouped
proteins <- read_csv(file.path(datapath, datafile)) 

# Group by protein name ---------------------------------------------------
proteins_by_protname <- group_by(proteins, proteins$Gene.proteins.symbol)

# Count rows bearing each protein name  --------
domains_per_protein <- summarize(proteins_by_protname, n())


# Plot start vs length ----------------------------------------------------

#plotset <- proteins_by_protname[proteins_by_protname$Gene.proteins.secondaryIdentifier == "YLL021W",]

plotset <- proteins_by_protname[proteins_by_protname$Gene.proteins.proteinDomains.name == "SM00326"|proteins_by_protname$Gene.proteins.proteinDomains.name == "PF00018",]

#plotset <- proteins_by_protname[500:600,]

qplot(data = plotset, x = plotset$Gene.proteins.proteinDomains.start, y = (plotset$Gene.proteins.proteinDomains.end -  plotset$Gene.proteins.proteinDomains.start), xlab = "Start", ylab = "Length", color = plotset$Gene.proteins.proteinDomains.name)


# mutate dataset to add domain column -------------------------------------

# Calculate distance between each point and neighbors ---------------------

# Try clustering ----------------------------------------------------------



