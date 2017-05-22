# read_and_plot_line.py
# reads two CSV data files of x, y values and plots a line plot
# usage: enter your path and filenames and labels.
# TODO: extend to more series
# TODO: standardize data input location

import pylab

def getData(fileName):
    dataFile = open(fileName, 'r')
    xVals = []
    yVals = []
    discardHeader = dataFile.readline()
    # or         header = f.readline().strip().split(',')
    for line in dataFile:
        x, y = line.split(",")
        # or             items = line.strip().split(',')
        xVals.append(float(x))
        yVals.append(float(y))
    dataFile.close()
    return (xVals, yVals)

def plotTwoData(file1, label1, file2, label2):
    x1, y1 = getData(file1)
    x2, y2 = getData(file2)
    x1Vals = pylab.array(x1)
    y1Vals = pylab.array(y1)
    x2Vals = pylab.array(x2)
    y2Vals = pylab.array(y2)
    xShifted = xShift(x1Vals,2.7) # manual correction for offset between two images
    pylab.plot(xShifted, y1Vals, 'b-', label = label1)
    pylab.plot(x2Vals, y2Vals, 'r-', label = label2)
    pylab.title('Profile of vertical objects')
    pylab.xlabel('Distance (µm)')
    pylab.ylabel('Intensity (AU)')
    pylab.legend(loc='best')

def xShift(xVals, amount):
    '''
    manual correction for offset between two images
    xVals = list
    amount = float or integer
    returns: mutated list
    '''
    for index in range(len(xVals)):
        xVals[index] += amount 
    return xVals
        
path = "/Users/confocal/Desktop/2017-05 resonant scanner/"
file1 = path+"reso2.csv"
label1 = "Resonant"
file2 = path+"galvo2.csv"
label2 = "Galvo"
plotTwoData(file1, label1, file2, label2)
pylab.show()

