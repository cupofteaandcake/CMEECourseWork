#!/usr/bin/env python3

"""This script runs TestR.R and then prints console and error file to Results file"""

__appname__ = 'TestR.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

import subprocess
subprocess.Popen("Rscript --verbose TestR.R > \
../Results/TestR.Rout 2> ../Results/TestR_errFile.Rout",\
shell=True).wait()