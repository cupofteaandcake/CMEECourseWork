#!/usr/bin/env python3

"""This function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula"""

__appname__ = 'get_TreeHeight.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

import sys
import math
import csv

def TreeHeight(distance, degrees):
    """function to calculate tree height using trigonometry"""
    radians = degrees * (math.pi/180)
    height = distance * math.tan(radians)
    print("Tree height is: {}".format(height))

    return height

def main(argv=sys.argv):
    """main function of the program"""
    input_csv = open("../Data/{}".format(argv[1]), 'r')
    TreeData = csv.reader(input_csv)
    a = [x for x in TreeData]
    newlist = a[0]
    newlist.append("Height_m")

    for lines in range(1,len(a)):
        line = a[lines]
        height = TreeHeight(float(line[1]), float(line[2]))
        line.append(height)
        newlist.append(line)


    # for i in newlist:
    #     print(i)

    output_file = "../Results/{}".format(argv[1])
    g = open(output_file, 'w')
    csvwrite = csv.writer(g)
    csvwrite.writerow(newlist[0:4])
    for i in newlist[4:]:
        csvwrite.writerow(i)
    g.close()

if __name__ == "__main__": 
    """Makes sure the "main" function is called from command line"""  
    status = main(sys.argv)
    sys.exit("Exit script")