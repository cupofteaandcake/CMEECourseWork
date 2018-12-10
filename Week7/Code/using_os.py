#!/usr/bin/env python3

"""This script is to extract the names of files and 
directories that match a certain naming pattern"""

#__appname__ = 'using_os.py'
#__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
#__version__ = '0.0.1'
#__license__ = "License for this code"

# Use the subprocess.os module to get a list of files and  directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions
import re
import subprocess

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir:
        z = re.match(r"^C", i)
        if z != None:
            FilesDirsStartingWithC.append(i)
    for j in files:
        q = re.match(r"^C", j)
        if q != None:
            FilesDirsStartingWithC.append(j)
  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:

#Get user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithCc = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir:
        z = re.match(r"[Cc]", i)
        if z != None:
            FilesDirsStartingWithCc.append(i)
    for j in files:
        q = re.match(r"[Cc]", j)
        if q != None:
            FilesDirsStartingWithCc.append(j)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

#Get user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
DirsStartingWithCc = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for i in subdir:
        z = re.match(r"[Cc]", i)
        if z != None:
            DirsStartingWithCc.append(i)