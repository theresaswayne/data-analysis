# count_domains.R
# Script to count number of detected domains per protein
# in records downloaded from SGD

# Input: CSV file from SGD with raw headers
# Must include Protein systematic name (secondary identifier), 
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

# Read files ---------------------------------------------------------------

# datapath <- "/Users/theresa/Documents/home-github/data-analysis/R/count_domains_data" # for home
datapath <- "/Users/confocal/github_theresaswayne/data-analysis/R/count_domains_data" # for work
datafile <- "20180302_SGDproteins_atleast1domain.csv"
pidfile <- "PID_accessions_only.csv"

# unlike base R's read.csv, readr's read_csv gives a tbl that can be grouped
proteins <- read_csv(file.path(datapath, datafile)) 

# a list of accession numbers, with header "Accession"
pids <- read_csv(file.path(datapath, pidfile))

# change tbl to vector
pids_acc <- pids$Accession

pid_proteins <- filter(proteins, Gene.proteins.proteinDomains.name %in% pids_acc)

# Group by protein name ---------------------------------------------------

proteins_by_protname <- group_by(proteins, proteins$`Gene.proteins.secondaryIdentifier`)
pid_proteins_by_name <- group_by(pid_proteins, pid_proteins$`Gene.proteins.secondaryIdentifier`)

# Count rows bearing each protein name  --------

domains_per_protein <- summarize(proteins_by_protname, n())
pid_domains_per_protein <- summarize(pid_proteins_by_name, n())

# use backticks around the column name because it has parentheses
inorder <- arrange(domains_per_protein, desc(`n()`))
pid_inorder <- arrange(pid_domains_per_protein, desc(`n()`))

# Create and save histogram of domains per protein ---------------------------------

outputgraph <- file.path(datapath,"domains_per_prot_redundant.pdf")
pdf(file = outputgraph)
hist(domains_per_protein$`n()`, 
     col = "blue", 
     main="Domains per protein including redundancies", 
     xlab="domains identified in SGD")
dev.off() # closes pdf output

pid_outputgraph <- file.path(datapath,"pid_domains_per_prot_redundant.pdf")
pdf(file = pid_outputgraph)
hist(pid_domains_per_protein$`n()`, 
     col = "blue", 
     main="PIDs per protein including redundancies", 
     xlab="PIDs identified in SGD")
dev.off() # closes pdf output

# Save data table -----------------------------------------------

outputfile <- "proteins_by_number_domains.csv"
write.csv(inorder, file.path(datapath,outputfile))

pid_outputfile <- "proteins_by_number_pids.csv"
write.csv(pid_inorder, file.path(datapath, pid_outputfile))
