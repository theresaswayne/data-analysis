# -*- coding: utf-8 -*-
"""
Created on Fri Jul 26 18:26:42 2019

@author: Shane
"""

import numpy as np
import pandas as pd
from pandas import Series, DataFrame
import scipy
import scipy.stats
import glob
import statsmodels.stats.api as sms
#import matplotlib for plotting
import matplotlib.pyplot as plt
# import matplotlib.cm as cm
import seaborn as sns
import math
from scipy.spatial import distance

#import os to handle operating system
import os
#============================================================================= 

#Goal: Import individual cable traces and calculate the architecture parameters
# to compare different mutants/strains.

#=============================================================================

#Set directory to import files to analyze
#datadir = 'input the directory that contains the txt files with cable traces' 

#Files MUST be in a directory called cable_traces
#============================================================================= 

datadir = '/Users/tcs6/Downloads/2022-08-30 lab mtg python/sample input/'

#initalize data frame to append all data 
df = pd.DataFrame()
df2 = pd.DataFrame()

#import and analyze each cable trace, then compile into a single dataframe

#use glob to find the files based on the patterns set above; change the
#directory as necessary

# File separator for Windows
#for f in glob.glob(datadir + 'cable_lengths\\' + '*' + '.txt'):
# File separator for Mac
for f in glob.glob(datadir + 'cable_traces//' + '*' + '.txt'):
    
    #read in the txt files with pandas, set header=None
    df = pd.read_table(f, header=None)

    #convert the txt file into a numpy arrray for length calculations
    arr = np.array(df)
    
    #calculate the end-to-end distance (D) of each cable
    dist = distance.euclidean(arr[0], arr[-1])
    
    #calculate the total length of the cable by summing the 
    #length of each segment
    lengths = np.sqrt(np.sum(np.diff(arr, axis=0)**2, axis=1)) 
    total_length = np.sum(lengths)
       
    #compile the calculations into a single dataframe for 
    #plotting/stats analysis
    df2 = df2.append([[os.path.basename(f), dist, total_length, \
                       total_length/dist]], ignore_index=True)
        
#name each column: cable number, euclidean dist, length, tortuosity
df2.columns = np.array(['cn', 'D', 'L','L/D'])

#============================================================================= 
#Optional: To compare actin cable length and architecture to aspects of cell
#size you can add cell size measurements from a separate data file
#to the dataframe. Change the directory, filename, and format below as needed.

# cell_size = pd.read_excel(datadir + 'filename')

# df2['cell_diameter'] = cell_size['d1'] #distance from bud neck to rear of cell
# df2['cell_diameter_2'] = cell_size['d2'] #cell width
# df2['cell_number'] = cell_size['cell_number'] #indiviudal cell number
# df2['strain'] = cell_size['strain'] #denotes strain/mutant
# df2['cell_volume'] = cell_size['volume'] #calculated volume
    
#============================================================================= 
#Output the data to csv for plotting and statistical analyses.

df2.to_csv('/Users/tcs6/Downloads/2022-08-30 lab mtg python/sample output/calculations/cablelength.csv', index=False)





 

