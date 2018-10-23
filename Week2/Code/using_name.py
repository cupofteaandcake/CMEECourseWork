#!/usr/bin/env python3

"""This script illustrates when program is being run itself or as a module in another program"""

__appname__ = 'using_name.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

if __name__ == '__main__':
    """Makes sure the "main" function is called from command line"""
    print('This program is being run by itself')
else:
    print('I am being imported from another module')