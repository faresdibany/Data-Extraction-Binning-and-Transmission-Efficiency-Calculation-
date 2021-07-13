# Data-Extraction-and-Processing-Pipeline-for-Mass-Spectrometry-
This repository is for python scripts to extract raw mass spectrometry data and create histograms for MS1 and MS2 frames and groups, summing the intensities, with respect to binned M/z and Scan. 
Recommended order of viewing the scripts: 1-Automatic_Data_Extraction.py
                                          2-Shifting_efficiency.py
                                          3-Histogram_per_Frame.py 
First file extracts data from raw mass spectrometry data, using Timspy, and then creates histograms of MS1 and MS2 groups, and calculates transmission efficiency for each MS2 group. 
Second file imports the transmission efficiency matrices, and starts shifting each scan by a specified value, depending on the programmed and the expected shift of the scans, in the m/z value
Third file extracts data from raw mass spectrometry data, using Timspy, and then creates histograms of single frames of binned intensities, with the goal to check whether following each MS1 frame, the first 3 frames pick up the signal or not. 

Detailed description of the code is in each script. 

The added matlab scripts are for fitting transmission efficiency curves to measured transmission efficiency curve, with the goal of acquiring the position of the ideal transmission efficiency, for each scan, in a specific midia group of an experiment, and also for visualizing the difference between fitted values and the isolation m/z. 
Recommended order of viewing the scripts: 1-lsq.m
                                          2-visualizing_position_difference_ideal_and_programmed.m
                                          3-visualizing_position_difference_ideal_and_programmed_same_midia_different_experiment.m 

The fitting is done using least squares method, where it is optimized, until the minimum of the objective function is reached. The optimized parameters are the beginning position of the left and right edges of the ideal transmission curve, and the edge width, in m/z values. Correlation between the left, right, and full curve, and the measured transmission efficiency curve is also calculated.  

After fitting is done, the parameter values for each scan and the correlations get saved into an excel sheet, for each midia group. 
