#!/usr/bin/env python3

"""Some functions exemplifying further applications of control statements"""

__appname__ = 'cfexercises2.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## imports ##
import sys #module to interface our program with the OS

## constrants ##

## functions ##
def foo1(x):
    return x ** 0.5

def foo2(x,y):
    if x > y:
        return x
    return y

def foo3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x): #recursive function
    if x == 1:
        return 1
    return x * foo5(x - 1)

def main(argv):
    print(foo1(10))
    print(foo1(36))
    print(foo2(5,1))
    print(foo2(1,10))
    print(foo3(2,1,4))
    print(foo3(1,3,6))
    print(foo3(7,3,1))
    print(foo3(8,9,4))
    print(foo4(6))
    print(foo4(3))
    print(foo5(6))
    print(foo5(3))
    return 0

if __name__ == "__main__":
    """Makes sure that the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)