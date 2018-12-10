#!/usr/bin/env python3

"""Compares the time taken for the vectorised stochastic (with gaussian fluctuations) Ricker Eqn"""

import time
import numpy as np
import scipy as sc
import matplotlib.pylab as p

# def stochrick(p0=np.random.uniform(0.5, 1.5, 1000), r=1.2, K=1, sigma=0.2, numyears=100):
#     #initialize
#     N = np.full([numyears, len(p0)], np.nan)
#     N[0,] = p0
  
#     for pop in range(0, len(p0)): #loop through the populations
#         for yr in range(1, numyears): #for each pop, loop through the years
#             N[yr,pop] = N[yr-1,pop] * np.exp(r*(1-N[yr-1,pop]/K) + np.random.normal(0, sigma, len(p0)))

#     return N

# f1 = p.figure()
# p.plot(stochrick())
# p.grid()
# p.show()

# start = time.time()
# stochrick()
# end = time.time()
# elapsed = end - start
# print("Time taken for unvectorised stochastic Ricker model to run: {}".format(elapsed))

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

def stochrickvect(p0=np.random.uniform(0.5, 1.5, 1000), r=1.2, K=1, sigma=0.2, numyears=100):
    """reproduces vectorised stochastic ricker eqn from Vectorize2.R"""
    #initialize
    N = np.full([numyears, len(p0)], np.nan)
    N[0,] = p0

    for yr in range(1, numyears): #for each pop, loop through the years
        N[yr,] = N[yr - 1,] * np.exp(r * (1 - N[yr - 1,] / K) + np.random.normal(0, sigma, len(p0)))

    return N

start2 = time.time()
stochrickvect()
end2 = time.time()
elapsed2 = end2 - start2

print("Time taken for vectorized Stochastic Ricker is: {}".format(elapsed2))