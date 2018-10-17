#!/usr/bin/env python3

"""This script illustrates how to use arguments in python"""

__appname__ = 'sysargv.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

import sys
print("This is the name of the script:", sys.argv[0])
print("Number of argumments:", len(sys.argv))
print("The arguments are:", str(sys.argv))