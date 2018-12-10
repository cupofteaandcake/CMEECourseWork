#!/usr/bin/env python3

"""This script is to illustrate how to optimise python scripts"""

__appname__ = 'profileme2.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

def my_squares(iters):
    """produces square of inputs"""
    out = [i ** 2 for i in range(iters)]
    return out

def my_join(iters, string):
    """joins together a string iter amount of times"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """runs the two previous functions"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")