#!/usr/bin/env python3

"""This script is to produce two graphs based on Lotka-Volterra model with pred-prey density dependence"""

__appname__ = 'LV2.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

##imports##

import sys
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p

##constants##

##functions##
def dCR_dt(pops, t=0):
    """generates output of Lotka_Volterra model with pred-prey density dependence"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R * (1 - (R / K)) - a * R * C
    dCdt = -z * C + e * a * R * C
    
    return sc.array([dRdt, dCdt])

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
RC0 = sc.array([R0, C0]) 

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1], 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics, r = {:.2}, a = {:.2}, z = {:.2}, e = {:.2}'.format(r, a, z, e), fontsize = 10)
f1.savefig('../Results/LV2_model.pdf')

# Phase Plot script

f2 = p.figure()
p.plot(pops[:,0], pops[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics, r = {:.2}, a = {:.2}, z = {:.2}, e = {:.2}'.format(r, a, z, e), fontsize = 10)
f2.savefig('../Results/LV2_phase_plot.pdf')