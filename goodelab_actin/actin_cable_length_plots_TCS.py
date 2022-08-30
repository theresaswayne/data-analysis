# -*- coding: utf-8 -*-
"""
Created on Fri Aug  2 16:39:25 2019

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
import matplotlib.cm as cm
import matplotlib.ticker as ticker
import seaborn as sns
import math
from scipy.spatial import distance

#import os to handle operating system
import os
#=============================================================================

#Goal: Compare measured cable architecture parameters from different strains/
#mutants. 

#=============================================================================
#Set directory to import files to analyze, and output directory to save

#datadir = 'input the directory that contains the CSV files with cable lengths' 
datadir = '/Users/tcs6/Downloads/2022-08-30 lab mtg python/sample input/cable data by strain/' 
savedir = '/Users/tcs6/Downloads/2022-08-30 lab mtg python/sample output/plots/' 

#=============================================================================
#Initalize data frame to append all data.
df = pd.DataFrame()

#Import data to dataframe, amend 'filename' as needed.
#df = pd.read_csv(datadir + filename)
df = pd.read_csv(datadir + 'cablelength_columns_added.csv')

#=============================================================================
#Optional: If you have multiple strains, conditions, and/or replicates
#the code below will calculate the means for these groups that can be used
#to generate 'SuperPlots'. 

df_means = df.groupby(['strain', 'expt_num'], sort=False).mean().reset_index()

df_means_sort = df.groupby(['expt_num', 'strain']).mean().reset_index()

    
#=============================================================================
#Set color palette to use for plots.
cmap = ["#f6511d", "#00a6ed", "#7fb800", "#ffb400", "#0d2c54"] 

#Order to plot strains
o = ["WT", "YKL003"]

#Font size for plots.
ft = 22     

#Set the style of plots.
st = 'ticks' 
#=============================================================================

#Plot each of the measured cable parameters.


#plot D
with sns.axes_style(st):
    plt.figure(figsize=(5,6))
    sns.set_palette(cmap)
    
    #Use swarmplot to plot all of the data points.
    sns.swarmplot(x='strain', y='D', data = df, linewidth=0.5,\
                  edgecolor='k', zorder=0, size=7, dodge=True) 
        
    #Use stripplot to plot the mean values of each replicate.    
    ax = sns.stripplot(x='strain', y='D', data = df_means_sort, size=15,\
                       color='grey', edgecolor='k', marker="s",\
                       linewidth=1, order = o)
        
    #Use pointplot to plot the means and 95%CI of all replicates.    
    ax = sns.pointplot(x='strain', y='D', data = df_means,\
                       capsize = 0.8, join=False, color='k')
        
    plt.ylabel(u'End-to-end distance(${\mu}m$)', fontsize=ft)
    plt.xlabel(None)
    ax.set(xticks=[])
    ax.tick_params('both', length=5, which='both')
    ax.yaxis.set_major_locator(ticker.MultipleLocator(2))            
    plt.rc('xtick', labelsize=12)
    plt.rc('ytick', labelsize=ft)
    plt.tight_layout()
    plt.ylim([0, 13])
    plt.legend([],[], frameon=False)
    plt.savefig(savedir + 'distance.png')
    

#plot L   
with sns.axes_style(st):
    plt.figure(figsize=(5,6))#use 3,4 for figures; 8,9 for terminal
    sns.set_palette(cmap)
    
    #Use swarmplot to plot all of the data points.    
    sns.swarmplot(x='strain', y='L', data = df, linewidth=0.5,\
                  edgecolor='k', zorder=0, size=7, dodge=True) 
        
    #Use stripplot to plot the mean values of each replicate.            
    ax = sns.stripplot(x='strain', y='L', data = df_means_sort, size=15,\
                       color='grey', edgecolor='k', marker="s",\
                       linewidth=1, dodge=True, order = o) 
        
    #Use pointplot to plot the means and 95%CI of all replicates.            
    ax = sns.pointplot(x='strain', y='L', data = df_means,\
                       capsize = 0.8, join=False, color='k')
        
    plt.ylabel(u'Cable length (${\mu}m$)', fontsize=ft)
    plt.xlabel(None)
    ax.set(xticks=[])
    ax.tick_params('both', length=5, which='both')    
    ax.yaxis.set_major_locator(ticker.MultipleLocator(2))            
    plt.rc('xtick', labelsize=12)
    plt.rc('ytick', labelsize=ft)
    plt.tight_layout()
    plt.ylim([0, 17])
    plt.legend([],[], frameon=False)
    plt.savefig(savedir + 'length.png')
    

#plot L/D   
with sns.axes_style(st):
    plt.figure(figsize=(5,6))#use 3,4 for figures; 8,9 for terminal
    sns.set_palette(cmap)

    #Use swarmplot to plot all of the data points.        
    sns.swarmplot(x='strain', y='L/D', data = df, linewidth=0.5,\
                  edgecolor='k', zorder=0, size=7, dodge=True)   

    #Use stripplot to plot the mean values of each replicate.                    
    ax = sns.stripplot(x='strain', y='L/D', \
                       data = df_means_sort, size=15,\
                       color='grey', edgecolor='k', marker="s",\
                       linewidth=1, dodge=True, order = o)
              
    #Use pointplot to plot the means and 95%CI of all replicates.                    
    ax = sns.pointplot(x='strain', y='L/D', data = df_means,\
                       capsize = 0.8, join=False, color='k')
        
    plt.ylabel('Tortuosity (L/D)', fontsize=ft)
    plt.xlabel(None)
    ax.set(xticks=[])
    ax.tick_params('both', length=5, which='both')
    ax.yaxis.set_major_locator(ticker.MultipleLocator(2))            
    plt.rc('xtick', labelsize=12)
    plt.rc('ytick', labelsize=ft)
    plt.tight_layout()
    plt.ylim([0, 8])
    plt.legend([],[], frameon=False)
    plt.savefig(savedir + 'tortuosity.png')
    












