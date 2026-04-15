# commands to process batch cell counts from cytation

require(tidyverse)

# split the filename into parts
# first part is well

counts_parsed <- counts %>% 
  mutate(Well = str_split_i(Label, "_", 1), .after = Label) %>%
  mutate(Position = str_split_i(Label, "_", 4), .after = Well) %>%
  mutate(Timepoint = str_split_i(Label, "_", -1), .after = Position) %>%
  mutate(Timepoint = as.numeric(substring(Timepoint, 1, 3))) %>%
  mutate(Hours = Timepoint * 12, .after = Timepoint)

counts_by_well <- counts_parsed %>%
  group_by(Well, Hours) %>%
  summarise(TotalCells = sum(Count))

timecourse <- ggplot(counts_by_well, aes(Hours, TotalCells, color =Well)) +
  geom_path()
