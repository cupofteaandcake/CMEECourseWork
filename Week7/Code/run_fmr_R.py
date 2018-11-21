#!/usr/bin/env python3

"""This script is to run fmr.R and print the console of this R script"""

__appname__ = 'run_fmr_R.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

import subprocess

p = subprocess.Popen(["Rscript", "fmr.R"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())

print("This script was succesful!")