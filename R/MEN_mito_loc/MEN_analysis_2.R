# MEN_analysis_2.R

# new approach to mito analysis based on tidying data
# ok I know it should be a branch so sue me

# 0. Start with combined file of all objects (df from combine_volocity_files.R) (no need to separate by temp)

# 1. Collect background values (filter for Population == ROIs, select filename, 470DCI columns)

# 2. Collect summarized mito values (filter for Population == Mito, group by filename and Whole cells ID, summarise as sum of 470DCI -- will do sum by cell first)

# 3. Collect the Whole cell rows (filter for Population == Whole cells)

# 4. Mutate the table from step 3 with additional columns for background and mito sum, making sure they are in the same order! (need to lookup somehow?)

# 5. Write a function for background corrected % in mito (or if you really want to add another column)

# 6. filter on temperature and boxplot the data from #5 

# 7. write a csv file