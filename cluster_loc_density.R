# import files with the following names:
# locs = export of grouped localizations from Picasso filter (1 localization = 1 row)
# area = export of cluster areas from dbscan (1 cluster = 1 row)

require(tidyverse)
locs_grouped <- group_by(locs, group) %>% summarise(localizations = n())

merged_locs <- full_join(locs_grouped, area, by=join_by(group))

# calculate global precision (LP)
LP <- mean(c(median(locs$lpx),median(locs$lpy)))*104

# convert LP2 area into real units
merged_locs_mod <- merged_locs %>% mutate(`Area (nm^2)` = `Area (LP^2)`*(LP^2))
merged_locs_mod <- merged_locs_mod %>% mutate(loc_density_per_nm2 = localizations/`Area (nm^2)`)

# save results
write_csv(merged_locs_mod, "cluster_data.csv")