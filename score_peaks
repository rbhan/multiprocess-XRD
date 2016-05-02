import os
import numpy as np
import math as m

def find_line(file,searchExp):
    f=open(file,'r')
    index=0
    for line in f:
        if searchExp in line:
            break
        index += 1
        
    return(index)
    f.close()

def perfect_peaks():
    file=open('perfect_peaks','r')
    lines=file.readlines()
    file.close()

    index=find_line('perfect_peaks','NUMBER OF PEAKS')
    global n_peaks
    n_peaks = int(lines[index+1])

    index=find_line('perfect_peaks','PEAK POS, LW BOUND, UP BOUND, INTENSITY, FWHM')
    perf_pos = []
    perf_lb = []
    perf_ub = []
    perf_int = []
    for l in range(index+1,n_peaks+index+1):
        elements=lines[l].split()
        perf_pos.append(elements[0])
        perf_lb.append(elements[1])	
        perf_ub.append(elements[2])
        perf_int.append(elements[3])

    return(perf_pos, perf_lb, perf_ub, perf_int)
    
def characterize_peaks(filename):
    file=open(filename,'r')
    lines=file.readlines()
    file.close()

    elements = [each.split('{', 1)[0] for each in lines]
    xye_data = [each.split('[', 1)[1] for each in elements]
    positions = [each.split(',', 1)[0] for each in xye_data]
    intensities = [each.split(', ', 2)[1] for each in xye_data]

    peak_pos = range(10)
    peak_int = range(10)
    peak_fwhm = range(10)
    peak_area = range(10)
    for i in range(0, len(perf_pos)):
        lb = perf_lb[i]
        ub = perf_ub[i]
        x_range = []
        y_range = []
        fwhm = []
    # get intensity of peak by finding max intensity in the peak range
        for index, pos in enumerate(positions):
            if pos > lb and pos < ub:
                x_range.append(float(pos))
                y_range.append(float(intensities[index]))
        peak_int[i] = max(y_range)
    # get area of the peak by summing up all I(2theta) in peak range -- NOT TRAPEZOID RULE
        peak_area[i] = sum(y_range)
    # get position of the peak
        for index, y in enumerate(y_range):
            if abs(float(y)-peak_int[i]) < 0.001:
                peak_pos[i] = float(x_range[index])
    # get fwhm of the peak
            if float(y) >= (peak_int[i]/2):
                fwhm.append(float(x_range[index]))
        if len(fwhm) >= 1:
            peak_fwhm[i] = fwhm[-1] - fwhm[0]
        else:
            peak_fwhm[i] = 0.0;
            
    return (peak_pos, peak_int, peak_fwhm, peak_area)
    
  xye_files = [f for f in os.listdir(os.getcwd()) if f.endswith('.xye')]
[perf_pos, perf_lb, perf_ub, perf_int] = perfect_peaks()

sfr_pos = np.zeros((len(xye_files), 11))
sfr_int = np.zeros((len(xye_files), 11))
sfr_fwhm = np.zeros((len(xye_files), 11))
sfr_area = np.zeros((len(xye_files), 11))
# sfr_AVG = np.zeros((4,11))
# sfr_STD = np.zeros((4,11))

for f in range(0,len(xye_files)): # for filename in xye_files:
    filename = xye_files[f]
    sfr = ((filename.split(".", 1)[0]).split("_",2)[1]).split("p",1)[1]
#     n_sfr = int(((filename.split(".", 1)[0]).split("n", 1)[1]))
    sfr_pos[f][0] = sfr
    sfr_int[f][0] = sfr
    sfr_fwhm[f][0] = sfr
    sfr_area[f][0] = sfr
    [peak_pos, peak_int, peak_fwhm, peak_area] = characterize_peaks(filename)
    for n_peak in range(1,len(perf_pos)+1):
        sfr_pos[f][n_peak] = float(peak_pos[n_peak-1])
        sfr_int[f][n_peak] = float(peak_int[n_peak-1])
        sfr_fwhm[f][n_peak] = float(peak_fwhm[n_peak-1])
        sfr_area[f][n_peak] = float(peak_area[n_peak-1]) 
        
print(sfr_area)
