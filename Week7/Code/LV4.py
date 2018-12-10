#!/usr/bin/env python3

"""This script is to produce two graphs based on discrete-time Lotka-Volterra model 
with pred-prey density dependence and random gaussian fluctuations"""

__appname__ = 'LV4.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

##imports##

import sys
import scipy as sc
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
import scipy.stats

##constants##

##functions##
def dCR_dt(R, C, t=0):
    """generates output of discrete-time Lotka_Volterra model with pred-prey density dependence
    and random gaussian fluctuations"""
    Rt = R
    Ct = C
    epsilon = sc.random.normal()
    Rt1 = Rt * (1 + ((r + epsilon) * (1 - (Rt / K))) - a * Ct)
    Ct1 = Ct * (1 - z + e * a * Rt)
    
    return sc.array([Rt1, Ct1])

try:
    r = float(sys.argv[1])
    a = float(sys.argv[2])
    z = float(sys.argv[3])
    e = float(sys.argv[4])
except (IndexError, ValueError):
    print("Using defaults values.")
    r = 1.
    a = 0.1
    z = 1.5
    e = 0.75

t = sc.linspace(0, 60, 1000)

K = 41

R0 = 10
C0 = 5 
RC0 = sc.array([[R0, C0]]) #array of arrays

for i in range(1000):
    #input the last list [R0, C0] in the RC0 array
    pops = dCR_dt(RC0[-1][0], RC0[-1][1])
    #append output to end of array
    RC0 = sc.vstack((RC0, pops))
    #finish looping if extinction occurs before 1000
    if pops[0] < 0:
        RC0[-1, 0] = 0
        print("Prey reached extinction at: {}".format(i))
        break
    if pops[-1] < 0:
        RC0[-1, -1] = 0
        print("Predator reached extintion at: {}".format(i))
        break

time = range(len(RC0))

f1 = p.figure()
p.plot(time, RC0[:,0], 'g-', label='Resource density') # Plot
p.plot(time, RC0[:,1], 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics, r = {:.2}, a = {:.2}, z = {:.2}, e = {:.2}'.format(r, a, z, e), fontsize = 10)
f1.savefig('../Results/LV4_model.pdf')

# Phase Plot script

f2 = p.figure()
p.plot(RC0[:,0], RC0[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics, r = {:.2}, a = {:.2}, z = {:.2}, e = {:.2}'.format(r, a, z, e), fontsize = 10)
f2.savefig('../Results/LV4_phase_plot.pdf')