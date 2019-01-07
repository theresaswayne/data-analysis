# install_favorite_packages.R

# Quickly bring favorite packages into a new R installation

# Packages to be installed ---------
faves <- c("here", # for easy relative paths
           "RANN", # for nearest neighbor
           "RColorBrewer", # for nice color palettes
           "swirl",  # for tutorials 
           "tidyverse")  

# tidyverse core includes readr, dplyr, tidyr, purrr, stringr, tibble, forcats, ggplot2


# Determine installed packages -----------
existing <- installed.packages()

# Determine what needs to be installed
need_to_install <- setdiff(faves, existing[,1])

# Update existing packages before installing anything new ------
update.packages()


# Install any needed packages

if (length(need_to_install) != 0) {
  install.packages(need_to_install)
} else {
  print("All packages were already installed.")
  }
