# count_domains.R
# Script to count number of detected domains per protein
# in records downloaded from SGD

# Input: CSV file from SGD with human-readable headers
# Must include Protein systematic name, 
# and all possible fields under protein domains.

# Output:
# 1. Frequency distribution table and histogram of domains per protein
# 2. Sorted table of proteins by # domains detected (1 row per protein)

# Next steps:
# -- eliminate redundant domains using start and end residues
# -- filter by domains that are involved in protein-protein interactions

# ==========

# 1. Read file and check for required columns
# (user input?)

# 2. Group by protein name

# Summarize(?) getting count 