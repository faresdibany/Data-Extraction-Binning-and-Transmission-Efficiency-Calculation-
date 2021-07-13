# -*- coding: utf-8 -*-
"""
Created on Wed May 26 12:21:46 2021

@author: Stefan
"""
#This script is to extract data from the raw data, and implement a histogram, binning the intensity signals
#with respect to the M/z range, and the scan range. This is to give a midia profile, for the assesment of 
#experiment 

 
import pathlib
from pprint import pprint
import pandas as pd 
from timspy.df import TimsPyDF
# from timspy.dia import TimsPyDIA
import numpy as np
import itertools
from fast_histogram import histogram2d
import functools
from functools import partial 
import matplotlib as plt 

#directs to the path of the experiment
path = pathlib.Path(r'D:\G210624_003_Slot1-8_1_2008.d')

#imports rawdata, using Timspy
D = TimsPyDF(path)

#acquiring MS1 frames as an array 
y = D.ms1_frames
#converting array to Dataframe, with the column named "Frame" 
y = pd.DataFrame(y, columns = ['frame'])

#extracting data from raw data for retention time between 20 and 40 minutes, or 1200 and 2400 seconds
#this is just to check for the minimum and maximum frame and scan numbers, for the binning. 
#it is then commented, and the program is re-run 
#X = D.rt_query(1200,2400)

#extracting data from raw data, with specific frames frames in mind. 
#in this case, ms1 data is extracted, by slicing the data for every ms1 frame
ms_one = D.query(frames=slice(1,42778,21), columns=['frame','scan','mz','intensity','retention_time'])

#this is to extract the sub matrix from the one above, for only the retention time between 20 and 40 minutes 
ms_one = ms_one[(ms_one['retention_time']>=1200) & (ms_one['retention_time']<=2400)]

#binning for the m/z range, with 0.2 Th increment, where the minimum and maximum are 50 and 1700, respectively. 
xedges = np.arange(50,1700.2,0.2)
#binning for the scan range, with 1 increment
yedges = np.arange(0,451)

#creating histogram, taking into consideration the binning edges, from above, and 
#extracting the m/z and the scans, from the MS1 data, extracted above, while the weights for the 
#histogram, or the values for each m/z and scan bin, are the intensities, from the MS1 file. 
#binning, basically, adds the intensities in the same bin of scan and m/z
H, xedges, yedges = np.histogram2d(ms_one.mz, ms_one.scan, bins=(xedges, yedges),weights=ms_one.intensity)

#as it is low collision energy experiment, to eliminate the noise, we eliminate signals below 200
#and make them equal to 0 
w = np.where(H<=200)
H[w] = 0

#converting the MS1 histogram, H, to a dataframe, so we could save it as a csv file
ms1 = pd.DataFrame(H)
ms1.to_csv(r'D:\G210624_003_Slot1-8_1_2008.d\Analysis\ms1.csv')

#initializing the list for the extraction of the data for all midia groups, and for the binning
#and histogram creation for each midia group
midia = []
midia_histograms=[]
#given that for this experiment,MS1 frames repeat after 21 frames, MS2 frames start from 2 and end at 21
#python always ends at the value less than the maximum by 1 
e = np.arange(2,22)
# e = 2
#initializing the list for transmission efficiency
efficiency = []

for i in range(len(e)):
#j runs over the values of the array, e. 
    j = e[i]
    #as mentioned before, same procedure of extracting MS1 data, however, here we run over 
    #the values of j, which starts at 2, and ends at 21
    ms2 = D.query(frames=slice(j,42798,21), columns=['frame','scan','mz','intensity','retention_time'])
    ms2 = ms2[(ms2['retention_time']>=1200) & (ms2['retention_time']<=2400)]
    # midia.append([j-1,ms2])
    #here we add the MS2 matrices to the "midia" list, where we would have 20 MS2 groups or datasets
    midia.append(ms2)
#k runs over each MS2 group, or each element of the midia list
for k in range(len(midia)):
    #creating a histogram, as in MS1, but runs over each dataset from the midia list. 
    HH,xedges,yedges=np.histogram2d(midia[k].mz,midia[k].scan,bins=(xedges,yedges),weights=midia[k].intensity)
    #eliminating the signals below 200, for noise elimination
    HH[np.where(HH<=200)]=0
    #adding MS2 group histograms to the midia_histograms list 
    midia_histograms.append([HH])
#u runs over each histogram in the midia_histograms list 
for u in range(len(midia_histograms)):
    #to get the transmission efficiency, we divide the MS2 histogram by the MS1 histogram
    #this is where the loop runs over each histogram, in accordance with "u"
    eff = midia_histograms[u][0]/H
    #finding the NaNs in the matrix, in case of a 0 in MS2 being divided by MS1
    a = np.isnan(eff)
    eff[a] = 0
    #finding the infinities in the matrix, as a nonzero MS2 signal can be divided by a 0 in MS1
    b = np.isinf(eff)
    eff[b]=0
    #adds the transmission efficiency matrices to the efficiency list 
    efficiency.append(eff)

#save transmission efficiency matrices to specified path as csv file, in a loop 
path1= "D:\G210624_003_Slot1-8_1_2008.d\Analysis"
for o in range(len(efficiency)):
    eff9 = pd.DataFrame(efficiency[o])
    eff9.to_csv(path1+'\ef'+str(o+1)+'.csv')

#save binned midia groups to the specified path as csv file, in a loop 
# for w in range(len(midia_histograms)):
#     midi = pd.DataFrame(midia_histograms[w][0])
#     midi.to_csv(path1+'\midia'+str(w+1)+'.csv')    
    

    