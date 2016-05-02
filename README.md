#Rebecca Han
#Written 4/9/2016 to calculate XRD for 10 structures per SFR in [0, 0.42] using pymatgen

1. running calculate_XRD.py
  - INPUT .vasp structure files
  - have all inputs in same directory as calculate_XRD.py
  - OUTPUT .xye files in pymatgen format: [[two_theta, intensity, {(h, k, l): mult}, d_hkl], ...]
2. processing spectra with score_peaks.py
  - INPUT .xye files in pymatgen format
  - have all inputs in same directory as score_peaks.py
  - currently does NOT output a file yet; prints to terminal instead
  - select peak attribute(s) to be displayed (i.e. position, intensity, area, fwhm)
3. post-processing optional
