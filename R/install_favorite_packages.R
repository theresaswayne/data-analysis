# install_favorite_packages.R

# Quickly bring favorite packages into a new R installation

# Packages to be installed ---------
faves <- c("here", # for easy relative paths
           "RANN", # for nearest neighbor
           "RColorBrewer", # for nice color palettes
           "swirl",  # for tutorials 
           "tidyverse",
           # "BiocManager", # Bioconductor 
           "devtools", # needed for Bioconductor and SMoLR
           "manipulateWidget")  # needed for SMoLR

# tidyverse core includes readr, dplyr, tidyr, purrr, stringr, tibble, forcats, ggplot2


# Determine installed packages -----------
existing <- installed.packages()

# Determine what needs to be installed
need_to_install <- setdiff(faves, existing[,1])

# Update existing packages before installing anything new ------
# checkBuilt parameter added for R 4.0
update.packages(checkBuilt=TRUE)

# Install any needed packages

if (length(need_to_install) != 0) {
  install.packages(need_to_install)
} else {
  print("All CRAN packages have been installed.")
}

# Bioconductor and SMoLR packages 
# source("https://bioconductor.org/biocLite.R")
# biocLite("BiocUpgrade")   # (biocLite is deprecated)
require(BiocManager)
require(devtools)
BiocManager::install() # update existing

if (!("EBImage" %in% existing)) {
  BiocManager::install("EBImage")
  print("Installed EBImage using BiocManager")
  }

# if (!("SMoLR" %in% existing)) {
#   install_github("ErasmusOIC/SMoLR", build_vignettes = TRUE)
#   print("Installed SMoLR from GitHub")
# }

print("Finished!")
