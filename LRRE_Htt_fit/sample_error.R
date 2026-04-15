set.seed(42)
df <- data.frame(x = rep(1:10,each=5), y = rnorm(50))

library(ggplot2)
library(dplyr)

df.summary <- df %>% group_by(x) %>%
  summarize(ymin = min(y),
            ymax = max(y),
            ymean = mean(y))

p <- ggplot(df.summary, aes(x = x, y = ymean)) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = ymin, ymax = ymax))

p
