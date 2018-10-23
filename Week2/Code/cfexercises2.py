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
def foo_1(x):
    """returns x to the power of 0.5"""
    return x ** 0.5

def foo_2(x,y):
    """returns the greater number from x and y"""
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    """rearranges the list of vectors"""
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    """returns the square of x"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x):
    """returns factorial of x recursively"""
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x):
    """returns factorial of x in a different way"""
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    """main entry point of the program"""
    print(foo_1(10))
    print(foo_1(36))
    print(foo_2(5,1))
    print(foo_2(1,10))
    print(foo_3(2,1,4))
    print(foo_3(1,3,6))
    print(foo_3(7,3,1))
    print(foo_3(8,9,4))
    print(foo_4(6))
    print(foo_4(3))
    print(foo_5(6))
    print(foo_5(3))
    return 0

if __name__ == "__main__":
    """Makes sure that the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)