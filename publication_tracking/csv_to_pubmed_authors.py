# -*- coding: utf-8 -*-
"""
Created on Fri Nov  4 10:47:59 2016

@author: Theresa Swayne, Columbia University, 2017

Dec. 2017: Updated to join first and last names with hyphen for more precision, 
and add wildcard to capture single or multiple initials.

Free to use with attribution.

Purpose: Search Pubmed for publications by shared resource users.
Inputs:  1 csv file created by iLab, containing list of core users
Output: 1 text file containing a Pubmed search query that can be pasted into pubmed
Usage:  1) In iLab, export the list of core customers in CSV format.
        2) Rename the file people.csv and place in the same directory as this script.
        3) Edit the STARTDATE and ENDDATE parameters as needed.
        3) Run the script.
        4) Open the file query.txt in the same directory, copy the entire file, and paste it into the pubmed search box.
(for an NCBI saved search, omit the date info)
        
"""

# edit these parameters to limit publication dates
# use yyyy/mm/dd format
# for present, enter "3000" for ENDDATE

STARTDATE = "2017/12/01" 
ENDDATE = "3000" 

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
#        last_firstinit = first_last[1] + " " + first_last[0][0:1] # last, space, 1st initial
        last_firstinit = first_last[1] + "-" + first_last[0][0:1]+ "*" # last, hyphen, 1st initial, star
        
        try:           
           pubmed_namelist.append(last_firstinit)

        except IndexError: # handle empty rows that produce 'list index out of range'
            continue
        
    return pubmed_namelist

# main program

# TODO: prompt for user list file

file = open("people.csv")

authorList = iLab_to_author(file)

# construct the author part of the search query 
# format swayne-t*[Author] OR emtage-l*[Author] 

query = ""
query += "(" # open parenthesis for enclosing all the authors
for i in range(len(authorList)):
    query += authorList[i]
    query += "[Author]"
    if i == len(authorList) - 1: # if we are on the last author in the list
        query += ")" # close parenthesis for authors
        break
    else:
        query += " OR "

# add institution (note that all authors have affiliations now, so if any author is with Columbia it will match)

query += " AND columbia university[Affiliation]"

# add publication date limits

query += ' AND ("' + STARTDATE + '"[PDAT] : "' + ENDDATE + '"[PDAT])'

# write to text file
queryfile = open("query.txt","w")  
queryfile.write(query)
queryfile.close()

# ? TODO: write to URL file...
# queryurl = open("query.webloc","w")
# queryurl.write('<?xml version="1.0" encoding="UTF-8"?> + '\n' + '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">' + '\n' + '<plist version="1.0">' + '\n' + '<dict>' + '\n' + '\t' + '<key>URL</key>')

