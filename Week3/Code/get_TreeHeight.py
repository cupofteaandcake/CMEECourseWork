#!/usr/bin/env python3
"""A program which can calculate the height of a tree based on the distance
of observation from the base of the tree (in metres) and the angle of elevation
of the tree, based on the trigonometric theorem. It takes csv files as input"""

__appname__ = 'TreeHeight.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this program"

## imports
import sys
import math
import csv

## constants
# math.pi is pi

## functions
def TreeHeight(degrees, distance):
    """Calculate the tree height based on angle to top of tree & distance from base of tree"""
    radians = degrees * math.pi / 180
    height = distance * math.tan(radians)
    print('Tree height is:', height)
    return height

def main(argv):
    """Main entry point of the program"""
    input_csv = "../Data/%d" %sys.argv[1]
    f = open(input_csv, 'r')
    TreeData = csv.reader(f)
    for species in TreeData:
        TreeHeight(TreeData[1], TreeData[2])
        

    
    
if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    sys.exit('This program is now being exited.')