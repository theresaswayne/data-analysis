#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul 20 16:48:37 2017

@author: confocal
"""


import pylab

def getData(fileName):
    ''' takes a csv filename
    returns a string imageName and an array of cell lengths (floats)
    assumes the columns are in order: row,image,x,y,angle,length
    '''
    dataFile = open(fileName, 'r')
    imageName = ""
    lengths = []
    discardHeader = dataFile.readline()
    # or         header = f.readline().strip().split(',')
    for line in dataFile:
        row,image,x,y,angle,cellLength = line.split(",")
        # or             items = line.strip().split(',')
        imageName = image # TODO: gather this just once for efficiency
        lengths.append(float(cellLength)) # gathers the length of the line
    dataFile.close()
    return (imageName, lengths)

# TODO: make lengths into an array of 3 columns

# TODO: write csv file containing these values and titled the same as the image
     
# TODO: replace with useful values   
path = "/Users/confocal/Desktop/2017-05 resonant scanner/"
file1 = path+"reso2.csv"
label1 = "Resonant"
file2 = path+"galvo2.csv"
label2 = "Galvo"
getData(file1)
pylab.show()

