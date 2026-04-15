# ---- Setup ----

require(tidyverse) # for reading and parsing, lead/lag
require(tcltk) # for file choosing
require(RANN) # for nearest neighbor analysis

# ---- User chooses the neuron file ----

neuronFile <- tk_choose.files(default = "", caption = "Select the file with synapsin puncta") # prompt user
neuronCoords <-read.csv(neuronFile, header = TRUE, sep = ",", colClasses = "double") %>%
  select(X,Y,Z)


gliomaFile <- tk_choose.files(default = "", caption = "Select the file with PSD95 puncta") # prompt user
gliomaCoords <-read.csv(gliomaFile, header = TRUE, sep = ",") %>%
  select(X,Y,Z)

# need to transform Z by the Z:XY ratio = 1/0.155
# first make the integer coordinates into doubles
xySize <- 0.155
zSize <- 1.00

transmute(gliomaCoords, Z = as.double(Z))
transmute(gliomaCoords, Z = Z*(zSize/xySize))

transmute(neuronCoords, Z = as.double(Z))
transmute(neuronCoords, Z = Z*(zSize/xySize))

##nn2 nearest neighbor
neurNearGlioma <- nn2(neuronCoords, query=gliomaCoords, k=1, searchtype = "radius", radius = 10)
gliomaNearNeuron <- nn2(gliomaCoords, query=neuronCoords, k=1, searchtype = "radius", radius = 10)

# If there are no neighbours then nn.idx will contain 0 and nn.dists will contain 1.340781e+154 for that point.
hist(neurNearGlioma$nn.dists)
hist(gliomaNearNeuron$nn.dists)


