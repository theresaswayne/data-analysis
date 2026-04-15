# plotting angular data
# based on sample code from https://www.tidyverse.org/blog/2024/03/ggplot2-3-5-0-coord-radial/

library(ggplot2)
library(patchwork)
library(scales)
library(tidyverse)

# mimic real data

ImageName <- seq(1,8)
AbsDA <- c(28.7414,2.5875,15.6397,34.2468,4.4737,3.8511,32.7533,18.5184)
Treatment <- c("LatA","LatA","LatA","LatA","DMSO","DMSO","DMSO","DMSO")
df <- data.frame(ImageName, AbsDA, Treatment) %>% group_by(Treatment)
# df <- example_dominant_angle %>% group_by(Treatment)

# plot real data with box
# comment out the facet_wrap line to get single graph

p_abs_box <- ggplot(df, aes(`AbsDA`, fill = Treatment)) +
  geom_boxplot() + 
  coord_radial(start = 0, end = 0.5 * pi) +
  facet_wrap(~Treatment,nrow=2) +
  ggtitle("Absolute DA")

print(p_abs_box)

# plot real data with histogram
# comment out the facet_wrap line to get single graph

# raw counts
p_abs_hist <- ggplot(df, aes(`AbsDA`,fill = Treatment)) +
  geom_histogram(alpha = 0.6) + 
  coord_radial(start = 0, end = 0.5 * pi) +
  # facet_wrap(~Treatment,nrow=2) +
  ggtitle("Absolute DA")

print(p_abs_hist)

# scale by density (each histogram has equal area)
# comment out the facet_wrap line to get single graph

p_abs_hist_scale <- ggplot(df, aes(x=`AbsDA`, y=..density..,fill = Treatment)) +
  geom_histogram(alpha = 0.6) + 
  coord_radial(start = 0, end = 0.5 * pi) +
  #facet_wrap(~Treatment,nrow=2) +
  ggtitle("Absolute DA")

print(p_abs_hist_scale)
