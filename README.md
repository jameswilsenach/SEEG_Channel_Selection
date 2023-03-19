# Spectral Principal Component Analysis for SEEG Channel Selection
Often S/EEG analysis requires the extraction of a small set of important channels for further analysis. This method uses Spectral Principal Component Analysis (SPCA), also called Spectral Proper Orthogonal Decomposition (SPOD) to determine which channels are the most important based on a predetermined energy cutoff.

## Installation
This function requires MATLAB v2019a or later as well as the implementations of SPCA, spod.m and inverse SPCA, invspod.m by Oliver Schmidt, saved to your MATLAB path, which is available here:
https://www.mathworks.com/matlabcentral/fileexchange/65683-spectral-proper-orthogonal-decomposition-spod

## Instructions
In order to run the function you will require an appropriate SEEG file saved as a MATLAB data array with dimensions RxMxT, where R is the number of repeated trials, M is the number of S/EEG channels and T is the length of each trial (recommended to be at least 20s or greater). The current model assumes an energy cutoff of 75%.

