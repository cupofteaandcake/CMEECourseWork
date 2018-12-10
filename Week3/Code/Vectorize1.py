#!/usr/bin/env python3

"""This script is to compare the time it takes to loop something in python in comparison to vectorising it"""

__appname__ = 'Vectorize1.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

import numpy as np
import time

def SumAllElements(M):
    """Function to sum all elements in a 2D-matrix"""
    Dimensions = M.shape
    Total = 0
    for i in range(0,Dimensions[0]):
        for j in range(0,Dimensions[-1]):
            Total = Total + M[i,j]
    return (Total)

M = np.random.rand(1000, 1000)

# Computes by running a loop and therefore will take longer (0.069s)
start = time.time()
SumAllElements(M)
end = time.time()
elapsed = end - start
print("Time taken for SumAllElements loop is: {}".format(elapsed))

# Computes by using a vector instead and is therefore quicker (0.002s)
start2 = time.time()
M.sum()
end2 = time.time()
elapsed2 = end2 - start2
print("Time taken for vectorised sum is: {}".format(elapsed2))