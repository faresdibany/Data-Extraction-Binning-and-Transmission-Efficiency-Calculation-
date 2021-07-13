# -*- coding: utf-8 -*-
"""
Created on Fri May 21 11:16:42 2021

@author: stefan
"""
#this code extracts raw data, and creates 1d arrays of intensities for all scans, for each single frame 
#this is to show whether, following an MS1 frame, the three consecutive MS2 frames pick up the signals of the MS1 

import pathlib
from pprint import pprint
import pandas as pd 
from timspy.df import TimsPyDF
# from timspy.dia import TimsPyDIA
import numpy as np
import itertools
import functools
from functools import partial 
import matplotlib as plt 

#direct to specified path
path = pathlib.Path(r'D:\G210528_001_Slot1-9_1_1760.d')
D = TimsPyDF(path)

#extracting data from raw data between specified retention time 
X = D.rt_query(1800,2400,columns = ['frame','scan','mz','intensity','retention_time'])

# scans = pd.DataFrame(np.arange(340,401))
# scans.columns = ['scan']

# X = X.merge(scans,on='scan')

# X = X[(X['mz']>=462.98) & (X['mz']<=467.02)]
# X = X[(X['mz']>=462.98) & (X['mz']<=500.02)]
# X = X[(X['scan']>=340)&(X['scan']<401)]

#specifying frame range. Starting value depends on the minimum value, changes with respect to
#midia group, and MS1 frame, from a certain retention time   
Frames = np.arange(17010,22617,21)
# sca = np.arange(220,301)
results = []

for i in range(len(Frames)):
#binning edges, with respect to scans
    xedges = np.arange(0,901)
#slicing the data file with respect to the specified frames above 
    Y = X[(X['frame']==Frames[i])]
    # X.frame=Frames[i]
    #creating histogram, with respect to frames and scans, where we would get a 1d Array for each frame, running over all scan
    #this histogram would add all intensities in each specific scan, for all frames in single group, whether MS1 or MS2
    H,xedges = np.histogram(Y.scan,bins = xedges,weights = Y.intensity)
    #appending histograms for each frame to the results list 
    results.append((Frames[i],H))

#initializing list    
midia10 = []
# k = np.arange(21423,41202,21)
#scan numbers 
e = np.arange(0,267)
for j in range(len(e)):
    #extracting all intensities for the scans and saving them as MS2 frame histograms 
    midia10.append(results[j][1])
    
#summing intensity values for each frame, and getting the result in a 1d Array 
o = [sum(i) for i in zip(*midia10)]
p=pd.DataFrame(o)
p.columns=['MIDIA20']
p.to_csv(r'D:\G210528_001_Slot1-9_1_1760.d\Frame by Frame\MIDIA20.csv')

