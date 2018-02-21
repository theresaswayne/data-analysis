# count_domains.R
# Script to count number of detected domains per protein
# in records downloaded from SGD

# Input: CSV file from SGD with human-readable headers
# Must include Protein systematic name, 
# and all possible fields under protein domains.
# assumes that the protein contains some domains

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

# 3. Summarize(?) getting count of rows for each protein name 
# because each row is 1 domain

# 4. Write data table of protein, # domains, sorted by # domains

# 5. Create histogram of domains per protein