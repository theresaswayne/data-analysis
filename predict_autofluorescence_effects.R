# predict_autofluorescence_effects.R
# to see whether cellular autofluorescence skews the apparent percentage of fluorescence in mito
# for Hana's MEN project 2019

# Terms

mito_mean <- 50 # "true" mean intensity in mito
cell_mean <- 10 # "true" mean intensity in whole cell

# TODO: update counts with reasonable relative sizes 

mito_count <- 100 # voxel count for mitochondria
cell_count <- 1000 # voxel count for whole cell

autofluor_mean <- 20 # mean autofluorescence

# Assumptions
# -- All means are corrected for camera/field background (extracellular)
# -- Autofluorescence is found equally in all parts of the cell including mitochondria

# Calculation of integrated density and mito fraction
IntDen <- function(mean_, count_, AF) { # underscores because mean and count may be reserved
  (mean_ + AF) * count_
}

mito_frac_AF <- IntDen(mito_mean, mito_count, autofluor_mean)
mito_frac_noAF <- IntDen(mito_mean, mito_count, 0)
mito_frac_ratio <- mito_frac_AF/mito_frac_noAF

# TODO: Apply to a range of AF values, means, counts, using sapply(?)
# TODO: Plot the fraction ratio vs the variable

# Q. Do the 2 fraction calculations diverge from each other with higher AF? Or do they stay proportional?
