#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul 20 16:48:37 2017

@author: confocal
"""

# assumes no headers, 5 columns

import pylab, os, csv

def getData(fileName):
    ''' takes a csv filename
    returns a string imageName and an array of cell lengths (floats)
    assumes the columns are in order: row,image,x,y,angle,length
    '''
    dataFile = open(fileName, 'r')
    imageName = ""
    lengths = []
#    discardHeader = dataFile.readline() # variable is not used -- this just gets rid of the header
    # or         header = f.readline().strip().split(',')
    for line in dataFile:
        image,x,y,angle,cellLength = line.split(",")
        # or             items = line.strip().split(',')
        imageName = image # TODO: gather this just once for efficiency
        lengths.append(float(cellLength)) # gathers the length of the line
    dataFile.close() # you have to close it or nobody can use it
    return (imageName, lengths)

path = "/Users/confocal/Desktop/input/" 

for i in range (1,8):
    
    filename = "MAX_psy265 36c 001_xy"+str(i)+" lengths.csv"
    file1 = path+filename
    
    name, cellLengths = getData(file1)
    
    print("name of the file is",name) 
    # TODO: take off the slice number
    # print("harvested the following lengths",cellLengths)
    
    
    #def chunks(l, n):
    #    n = max(1, n)
    #    return (l[i:i+n] for i in xrange(0, len(l), n))
    
    groupedLengths = [cellLengths[i:i+3] for i in range(0, len(cellLengths), 3)]
    #print("I grouped the lengths in 3s:",groupedLengths)
    
    # TODO: create csv file titled the same as the image
    # write headers
    # filename, cell number, mother, bud initial, bud final [eventually b:m initial, b:m final]
    
    # setup output file
    csvPath = path + os.sep + "collated_lengths_"+str(i)+".csv"
    csvExists = os.path.exists(csvPath)
    csvFile = open(csvPath, 'a') # creates the file. a for append (b not necessary in python 3)
    csvWriter = csv.writer(csvFile) # this object is able to write to the output file
    
    # add headers to output file
    if not csvExists: # avoids appending multiple headers
        headers1 = ['Filename','cell number','mother diam um','bud initial um', 'bud final um']
        csvWriter.writerow(headers1)
    else:
        print("Appending to existing file.")
        
    cellNum = 0
    for group in groupedLengths:
        cellNum += 1
        collectedData = [name, cellNum]
        for value in group:
            collectedData.append(value)
        print("the next line is",collectedData)
        csvWriter.writerow(collectedData)
    
    csvFile.close() 
    print("finished field",i)

#TODO: get ratios by using arrays


print("finished")