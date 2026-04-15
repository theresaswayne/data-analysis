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

library(ggplot2)
library(dplyr)

# Open histogram data -----------------------------------------------------

#histofile <- file.choose() # opens a file chooser window, no message; returns full path
#histodata <- read_csv(mydatafile) 


# Plot the histogram ----------------------------------------------------




# Mark various quantiles ----------------------------------

# stolen from SO --  
# https://stackoverflow.com/questions/27104007/draw-vertical-quantile-lines-over-histogram

# dataset
v <- c(1:30, 2:50, 1:20, 1:5, 1:100, 1, 2, 1, 1:5, 0, 0, 0, 5, 1, 3, 7, 24, 77)

# a histogram object is a list
h <- hist(v, breaks=c(0:100), plot = FALSE)

# create 2 density tables from the histo
# mids = midpoints of bins, density = value of probability density function 

df1 <- data.frame(h$mids,h$density,rep("dataset1", 100))
colnames(df1) <- c('Bin','Pdf','Dataset')

# a "stretched" histogram (but the densities also doubled?)
df2 <- data.frame(h$mids*2,h$density*2,rep("dataset2", 100))
colnames(df2) <- c('Bin','Pdf','Dataset')

# combined data
df_tot <- rbind(df1, df2)

# ggplot(data=df_tot[which(df_tot$Pdf>0),], aes(x=Bin, y=Pdf, group=Dataset, colour=Dataset)) +
#     geom_point(aes(color=Dataset), alpha = 0.7, size=1.5)

# calculate quantile (of bin)
q.95 <- df_tot %>%
  group_by(Dataset) %>%
  summarise(Bin_q.95 = quantile(Bin, 0.95))

# plot data and add previously calculated line
p <- ggplot(data=df_tot[which(df_tot$Pdf>0),],
      aes(x=Bin, y=Pdf, group=Dataset, colour=Dataset)) +
      geom_point(aes(color=Dataset), alpha = 0.7, size=1.5) +
      geom_vline(data = q.95, aes(xintercept = Bin_q.95, colour = Dataset))

# you need to print the ggplot object in a script, to show it in the plot window
print(p)

# save the quantiles before creating the data frames, then creating a dataframe with them and plotting it with geom_vline.
# Report quantiles to try on image --------------------------------------------------------


# Generate some sample data, then compute mean and standard deviation
# in each group
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)
ds <- plyr::ddply(df, "gp", plyr::summarise, mean = mean(y), sd = sd(y))

# The summary data frame ds is used to plot larger red points on top
# of the raw data. Note that we don't need to supply `data` or `mapping`
# in each layer because the defaults from ggplot() are used.
ggplot(df, aes(gp, y)) +
  geom_point() +
  geom_point(data = ds, aes(y = mean), colour = 'red', size = 3)
