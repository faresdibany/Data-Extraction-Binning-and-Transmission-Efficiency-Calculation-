# -*- coding: utf-8 -*-
"""
Created on Thu May 27 09:26:58 2021

@author: Stefan
"""
#this code is to import the created histograms from the previous "Automatic_Data_Extraction" 
#code, and shift the efficiency profile, according to the expected shift of M/z from the program
import pandas as pd 
import numpy as np 

#importing the efficiency matrix
eff = pd.read_csv(r'D:\G210528_001_Slot1-9_1_1760.d\Analysis1_251\ef10.csv',index_col=0)
eff.columns = eff.columns.map(str)


counter = 0
#running the loop over all scans
for i in range(0,901):
    #shifting the columns, corresponding to the scan number by 10 multiplied by the scan number. 
    #the value 10 changes, with respect to the M/z binning increment done in creating the histograms. 
    #in this case, the increment was 0,125, and the expected shifting was 1.25 Th
        eff[str(counter)]=eff[str(counter)].shift(10*i)
        #runs over the next scan
        counter+=1
        #converts any NaNs to 0
        eff.fillna(0)
#saves file to csv         
eff.to_csv(r'D:\G210528_001_Slot1-9_1_1760.d\Analysis1_251\Shifted\ef10 shifted.csv')