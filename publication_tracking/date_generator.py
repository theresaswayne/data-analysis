# -*- coding: utf-8 -*-
"""
Created on Tue Feb 28 15:10:00 2017

@author: confocal

generates a list of dates between two specified dates at a specified interval
"""

import datetime
date1 = '2017/01/01'
date2 = '2017/03/01'
interval = 7

start = datetime.datetime.strptime(date1, '%Y/%m/%d')
end = datetime.datetime.strptime(date2, '%Y/%m/%d')
step = datetime.timedelta(days=interval)
while start <= end:
    s = str(start.date()).replace("-","/")
    print(s)
    start += step
    