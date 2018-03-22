
# input_demo.R
# Opens a file chooser, reads the selected file into a dataframe (assuming CSV)
#   and shows its attributes 

# No specific error catching; invalid files will show errors in console

mydatafile <- file.choose() # opens a file chooser window, no message
mydata <- read.csv(mydatafile) # we have the full file path
specs <- attributes(mydata)
print(specs)
