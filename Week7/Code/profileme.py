#!/usr/bin/env python3

"""This script is to illustrate how to profile python scripts"""

__appname__ = 'profileme.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

def my_squares(iters):
    """sqaures input"""
    out = []
    for i in range(iters): #range produces an implicit loop through which the loop can iterate
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """joins together any string iter amount of times"""
    out = ''
    for i in range(iters):
        out += string.join(", ") #out is equal to out + string (+=)
    return out

def run_my_funcs(x,y):
    """runs the previous two scripts"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000, "My string")