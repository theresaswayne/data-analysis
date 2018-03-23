# test_quantiles.R
# goal: measure cytoplasmic background from image histograms (typically Z stacks)
# method: test what quantiles of the histogram safely define the cytoplasm
#   then decide if mean, median, or some other measure is the best choice for threshold
#   compare to manually measured values
# use this data to generate automatic thresholds for Htt inclusion body images

# constraints: image contains several components:
#   extracellular background (relatively constant intensity)
#   cytoplasmic background (quite variable, but will compose a fair percentage of the total)
#   IB (may or may not be present, relatively small but variable area, highly variable intensity)

histofile <- file.choose() # opens a file chooser window, no message; returns full path
histodata <- read.csv(mydatafile) 

# stolen from SO 
# https://stackoverflow.com/questions/27104007/draw-vertical-quantile-lines-over-histogram

library(ggplot2)
v <- c(1:30, 2:50, 1:20, 1:5, 1:100, 1, 2, 1, 1:5, 0, 0, 0, 5, 1, 3, 7, 24, 77)
h <- hist(v, breaks=c(0:100))
df1 <- data.frame(h$mids,h$density,rep("dataset1", 100))
colnames(df1) <- c('Bin','Pdf','Dataset')
df2 <- data.frame(h$mids*2,h$density*2,rep("dataset2", 100))
colnames(df2) <- c('Bin','Pdf','Dataset')
df_tot <- rbind(df1, df2)

ggplot(data=df_tot[which(df_tot$Pdf>0),], aes(x=Bin, y=Pdf, group=Dataset, colour=Dataset)) +
  geom_point(aes(color=Dataset), alpha = 0.7, size=1.5)

library(dplyr)
q.95 <- df_tot %>%
  group_by(Dataset) %>%
  summarise(Bin_q.95 = quantile(Bin, 0.95))

ggplot(data=df_tot[which(df_tot$Pdf>0),], 
       aes(x=Bin, y=Pdf, group=Dataset, colour=Dataset)) +
  geom_point(aes(color=Dataset), alpha = 0.7, size=1.5) + 
  geom_vline(data = q.95, aes(xintercept = Bin_q.95, colour = Dataset))
