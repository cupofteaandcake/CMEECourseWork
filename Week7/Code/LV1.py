#!/usr/bin/env python3

"""This script is to produce two graphs based on Lotka-Volterra model"""

__appname__ = 'LV1.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

##imports##
import scipy as sc
import scipy.integrate as integrate
import matplotlib.pylab as p

##functions##
def dCR_dt(pops, t=0):

    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return sc.array([dRdt, dCdt])

r = 1.
a = 0.1 
z = 1.5
e = 0.75
t = sc.linspace(0, 15,  1000)
R0 = 10
C0 = 5 
RC0 = sc.array([R0, C0]) 

pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
f1.savefig('../Results/LV_model.pdf')

# Phase Plot script

f2 = p.figure()
p.plot(pops[:,0], pops[:,1], 'r-') # Plot
p.grid()
p.xlabel('Resource density')
p.ylabel('Consumer density')
p.title('Consumer-Resource population dynamics')
f2.savefig('../Results/phase_plot.pdf')