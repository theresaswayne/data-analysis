setwd("/Users/kate/Desktop/test")

#Make Coordinate Table for Tregs
TregData<-read.csv("TregROI.csv", header = TRUE, sep = ",")
View(TregData)
head(TregData)
names(TregData)
TregX<-TregData$X
TregY<-TregData$Y
TregCoord<-data.table(TregData$X.1,TregX,TregY, keep.rownames=TRUE)
plot(TregX,TregY)

MesData<-read.csv("PDGFRaROI.csv", header = TRUE, sep = ",")
View(MesData)
head(MesData)
names(MesData)
MesX<-MesData$X
MesY<-MesData$Y
MesCoord<-data.table(MesData$X.1,MesX,MesY, keep.rownames=TRUE)
plot(MesX,MesY)

##nn2 nearest neighbor
##package is rann
install.packages("RANN")
TregDist<-nn2(MesCoord, query=TregCoord, k=1, esp=0.0)
hist(TregDist$nn.dists)

##compare to random set of objects, t.test
