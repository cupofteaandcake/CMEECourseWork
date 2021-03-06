#!/usr/bin/env python3

"""Script illustrating the use of doctests"""

__appname__ = 'test_control_flow.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
import doctest # Import the doctest module

def even_or_odd(x=0):
    """Find whether a number x is even or odd.
      
    >>> even_or_odd(10)
    '10 is Even!'
    
    >>> even_or_odd(5)
    '5 is Odd!'
    
    whenever a float is provided, then the closest integer is used:    
    >>> even_or_odd(3.2)
    '3 is Odd!'
    
    in case of negative numbers, the positive is taken:    
    >>> even_or_odd(-2)
    '-2 is Even!'
    
    """
    #Define function to be tested
    if x % 2 == 0:
        return "%d is Even!" % x
    return "%d is Odd!" % x

###### I SUPPRESSED THIS BLOCK: WHY? #######

def main(argv):
    """main entry point of program"""
    print even_or_odd(22)
    print even_or_odd(33)
    return 0

if (__name__ == "__main__"):
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
############################################
    
# doctest.testmod()   # To run with embedded tests
