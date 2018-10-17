#!/usr/bin/env python3

"""Script to try how to use pdb on"""

__appname__ = 'debugme.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

def createabug(x):
    y = x**4
    z = 0.
    #import ipdb; ipdb.set_trace()
    y = y/z
    return y

createabug(25)