# -*- coding: utf-8 -*-
"""
Created on Fri Nov  4 10:47:59 2016

@author: confocal

Purpose: Make it easier to find core facility publications by narrowing down columbia publications (100+/week) to those authored by facility users.
Inputs:  2  files: 
    1) CSV list of core users from ilab; 
    2) list of recent Columbia publications from pubmed (this might be xml)
Output: 1 text file of a Pubmed url that will bring up the papers authored by facility users.

"""

import csv

def iLab_to_author(file):
    ''' takes an iLab users file and returns a list of author names in pubmed format '''

    orig_namelist = [] # list of names in iLab format
    pubmed_namelist = [] # list of names in pubmed author format

    for row in csv.reader(file):
        try:
            # ilab file format: name (f m l), title, email, labs, institutions, phone
            orig_namelist.append(row[0]) # get the first column from the CSV file

        except IndexError: # handle empty rows that produce 'list index out of range'
            continue

    del orig_namelist[0] # remove column header
   
    for name in orig_namelist:
        
        # get first and last names
        first_last = name.split("  ")   # there are 2 spaces between first and last names

        # re-order name
        last_firstinit = first_last[1] + " " + first_last[0][0:1] # last, space, 1st initial
        
        try:           
           pubmed_namelist.append(last_firstinit)

        except IndexError: # handle empty rows that produce 'list index out of range'
            continue
        
    return pubmed_namelist

#def pubmed_to_xml(file):
#    '''takes a pubmed results list in non-perfect xml format
#    writes the file with tags added at beginning and end'''
#    
#    import codecs
#    f = codecs.open(file, encoding='utf-8', mode='r+')
#
#    old = f.read() # read everything in the file
#    f.seek(0) # rewind
#    f.write('<?xml version="1.0" encoding="UTF-8"?>' + '\n' + '<data>' + '\n' + old)
#    f.close()
#
#    # append the final close tag
#    with open(file, 'a') as f: # allows appending and automatically closes
#        f.write('</data>\n')
#        
#    return f

# main program

# 1. Convert iLab users to pubmed author format

# TODO: prompt for user list file

userfile = open("people_short.csv")

authorList = iLab_to_author(userfile)

print(authorList)

# 2. Parse a pubmed xml to get all the author names

# TODO: prompt for a list of pubmed references in xml

# put pubmed results in proper xml format
import codecs
f = codecs.open('pubmed.xml', encoding='utf-8', mode='r+')

old = f.read() # read everything in the file
f.seek(0) # rewind
f.write('<?xml version="1.0" encoding="UTF-8"?>' + '\n' + '<data>' + '\n' + old)
f.close()
with open('pubmed.xml', 'a') as f: # allows appending and automatically closes
    f.write('</data>\n') # append the final close tag
        

# TODO: def match authors
    # for each user name from the iLab list
    # find all records from the pubmed list with a matching author name (or search for recent pubmed ids by that author??)
    # and append the matches (by pubmed id?) to a new list or file

# OR def match ids 
    # for each user name from the iLab list
    # search for recent pubmed ids by that author
    # and append the matched pubmed ids to a new list or file

# TODO def translate the pubmed ids into an url that we can open to see the list of pubmed records
# sample url based on pubmed id: 
# https://www.ncbi.nlm.nih.gov/pubmed/28097863%2C28098202%2C28094292%2C28089515%2C28083655


# TODO: test with single match, multiple match, no match, first initial only
