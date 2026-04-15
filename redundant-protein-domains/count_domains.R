# count_domains.R
# Script to count number of detected domains per protein
# in records downloaded from SGD
# filtered by a list of accession numbers denoting PIDs (protein interaction domains)

# Input: 
# 1) CSV file from SGD with raw headers; 
#   must include Protein systematic name (secondary identifier), 
#   and all possible fields under protein domains.
#   Assumes that the protein contains some domains.
# 2) CSV file of accession numbers for filtering

# Output (Note: over-writes without warning!):
# 1. Histogram of PIDs per protein
# 2. Sorted table of proteins by frequency of PIDs detected (1 row per protein)
# 3. Table of protein domains filtered on PIDs (including only the PIDs)

# Next steps:
# -- eliminate redundant domains using start and end residues

# Refinements:
# -- prompt user for files
# -- check for required columns
# -- rename columns in summary to something sensible
# -- don't create so many new dataframes, but mutate instead (e.g. when sorting)

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

# Filter to count only PIDs -----------------------------------------------

pids <- read_csv(file.path(datapath, pidfile)) # a list of accession numbers, with header "Accession"
pids_acc <- pids$Accession # change tbl to vector
pid_proteins <- filter(proteins, Gene.proteins.proteinDomains.name %in% pids_acc)

# Count rows bearing each protein name  and sort by # domains --------

# grouped table = easier to count rows within a category
pid_proteins_by_name <- group_by(pid_proteins, pid_proteins$`Gene.proteins.secondaryIdentifier`)
pid_domains_per_protein <- summarize(pid_proteins_by_name, n())
pid_inorder <- arrange(pid_domains_per_protein, desc(`n()`)) # backticks because of parentheses in column name

# Histogram of PIDs per protein ---------------------------------

pid_outputgraph <- file.path(datapath,"pid_domains_per_prot_redundant.pdf")
pdf(file = pid_outputgraph)
pid_freqs <- pid_domains_per_protein$`n()`
hist(pid_freqs,
     breaks = seq(1:max(pid_freqs)),
     col = "blue",
     main="PIDs per protein including redundancies", 
     xlab="PIDs identified in SGD")
dev.off() # closes pdf output

# Data tables -----------------------------------------------

freq_outputfile <- "proteins_by_number_pids.csv"
write.csv(pid_inorder, file.path(datapath, freq_outputfile))

pid_outputfile <- "all_proteins_with_pids.csv"
write.csv(pid_proteins_by_name, file.path(datapath, pid_outputfile))

