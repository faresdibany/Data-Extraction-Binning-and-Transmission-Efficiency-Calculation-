# Data-Extraction-and-Processing-Pipeline-for-Mass-Spectrometry-
This script is to extract raw mass spectrometry data and create histograms for MS1 and MS2 frames and groups, summing the intensities, with respect to binned M/z and Scan
Recommended order of viewing the scripts: 1-Automatic_Data_Extraction.py
                                          2-Shifting_efficiency.py
                                          3-Histogram_per_Frame.py 
First file extracts data from raw mass spectrometry data, using Timspy, and then creates histograms of MS1 and MS2 groups, and calculates transmission efficiency for each MS2 group. 
Second file imports the transmission efficiency matrices, and starts shifting each scan by a specified value, depending on the programmed and the expected shift of the scans, in the m/z value
Third file extracts data from raw mass spectrometry data, using Timspy, and then creates histograms of single frames of binned intensities, with the goal to check whether following each MS1 frame, the first 3 frames pick up the signal or not. 

Detailed description of the code is in each script. 
