# test_file_input.R
# ---- Setup ----

require(tidyverse) # for data processing
require(stringr) # for string harvesting
require(tcltk) # for directory choosing



# ---- User opens the three results files ----

print("choosing one file")
ilabfile <- file.choose()
datadir <- dirname(ilabfile)
ilabdata <- read_csv(ilabfile)

print("choosing multiple with choose.files()")

ilabfile <- file.choose()
datadir <- dirname(ilabfile)
ilabdata <- read_csv(ilabfile)
datafiles <- tk_choose.files(default = "", caption = "Use Ctrl-click to select ALL THREE results files",
                             multi = TRUE, filters = NULL, index = 1)
datadir <- dirname(datafiles)[1] # IMPORTANT select just one of the directories (they are the same)
# note if datadir was not reduced to 1 element, it would read the table multiple times into the same dataframe!

datanames <- basename(file.path(datafiles)) # file names without directory names

# read the files

measfile <- datanames[grepl("_Results", datanames)]
meas <- read_csv(file.path(datadir, measfile))

numfile <- datanames[grepl("Num", datanames)]
nummeas <- read_csv(file.path(datadir,numfile)) 

denomfile <- datanames[grepl("Denom", datanames)]
denommeas <- read_csv(file.path(datadir,denomfile)) 