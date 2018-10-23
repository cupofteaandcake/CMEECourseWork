#!/usr/bin/env python3

"""This script demonstrates the usability of local and global variables"""

__appname__ = 'scope.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#first
_a_global = 10

def a_function():
    """doesn't actually change the global value"""
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()

print("Outside the function, the value is ", _a_global)

#second
_a_global = 10

def a_function():
    """changes the global value from 10 to 5"""
    global _a_global
    _a_global = 5
    _a_local = 4
    print("Inside the function, the value is ", _a_global)
    print("Inside the function, the value is ", _a_local)
    return None

a_function()
print("Outside the function, the value is ", _a_global)