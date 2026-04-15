#########################################################################
#               Combine and Merge Different Data Sets                   #
#########################################################################  

# Load data

setwd("C:/Users/Julia Thompson/OneDrive - cumc.columbia.edu/Documents/R Videos")

low_birth = read.csv("bwt_Low.csv")
norm_birth = read.csv("bwt_Normal.csv")

# Combine 'low' and 'normal' data sets by row to obtain 'combo_row'

combo_row <- rbind(low_birth, norm_birth)
head(combo_row)

dim(low_birth)
dim(norm_birth)
dim(combo_row)

# Note: you can also combine by column using function cbind()

#########################################################################
#                  Merging data sets: Application                       #
#########################################################################

# A study was conducted to identify risk factors for low infant birth weight using data from 189 live births
# at Bay State Medical Center in Massachusetts. Low birth weight was defined as a <2500grams.

# Combine the low birth weight babies (bwt_LOW.csv) with the normal birth weight babies (bwt_Normal.csv).
# This is the combo_row data from above

# Merge the combo_row data with data on # of visits (bwt_ADMIN.csv).
# id  = ID number of infant
# visits = number of physician visits during 1st trimester = 0 if none; 1 if one; 2 if two or more

admin_birth<-read.csv("bwt_Admin.csv")

# See below for the solution:

birth_final <- merge(combo_row,admin_birth, by="id")
names(birth_final)
head(birth_final)

# Export merged data to a CSV file

write.csv(birth_final, file="bwt_Stats.csv")

