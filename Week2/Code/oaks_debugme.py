#!/usr/bin/env python3

"""A python script which searches for oaks in a csv of tree species
and prints them to a new csv file"""

__appname__ = 'oaks_debugme.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

## Imports
import csv
import sys
import doctest

## Functions
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'.
    >>> is_an_oak('Fagus sylvatica')
    False

    >>> is_an_oak('Quercus alba')
    True

    Even if Quercus is spelled incorrectly, e.g. Quercuss, it will be correctly identified.
    >>> is_an_oak('Quercuss ilex')
    False

    >>> is_an_oak('Equercus pandora')
    False

    >>> is_an_oak('Quercusilva minimus')
    False
    """
    l = name.split(' ', 2)
    word = l[0]
    if len(word) != 7:
        return False
    else:
        return word.lower().startswith('quercus')

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    next(taxa)
    csvwrite = csv.writer(g)
    csvwrite.writerow(['Genus', 'Species'])
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

# doctest.testmod()