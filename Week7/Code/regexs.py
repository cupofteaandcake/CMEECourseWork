#!/usr/bin/env python3

"""This script is to run the regex exercises from week 7"""

__appname__ = 'regexs.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

import re

my_string = "a given string"

match = re.search(r'\s', my_string)
print(match)
match.group()

match = re.search(r'\d', my_string)
print(match)

MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) #match preceding pattern (alphanumeric character 'word') 0 or more times, and then match a white space
if match:
    print('found a match:', match.group())
else:
    print('did not find a match')

match = re.search(r'2', "it takes 2 to tango")
match.group() #matches 2

match = re.search(r'\d', "it takes 2 to tango")
match.group() #matches number

match = re.search(r'\d.*', "it takes 2 to tango")
match.group() #matches number preceding

match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group() #matches space, alphanumeric which appears only 1-3 times & then space

match = re.search(r'\s\w*$', 'once upon a time')
match.group() #matches space, 'word' and then end of string

re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()

re.search(r'^\w*.*\s', 'once upon a time').group()

re.search(r'^\w*.*?\s', 'once upon a time').group()

re.search(r'<.+>', 'This is a <EM>first</EM> test').group()

re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

re.search(r'\d*\.?\d*','1432.75+60.22i').group()

re.search(r'[AGTC]+', 'the sequence ATTCGT').group()

re.search(r'\s+[A-Z]{1}\w+\s\w+', 'The bird-shit frog"s name is Theloderma asper').group()

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
match.group()

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
match.group()

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

#RegExercises
#Regex1
MyStr = 'Thal!a Al-Mushadani'
match = re.search(r"[\w\s\?\-\!\+]+",MyStr)
match.group()

#Regex2
# r'^abc[ab]+\s\t\d' means at the beginning of the string find abc,
# then either a or b at least once, followed by a space, a tab 
# & finally a number.
# r'^\d{1,2}\/\d{1,2}\/\d{4}$' means at the beginning of the string, 
# find a 1-2 digit number, followed by a forward slash,
# and another 1-2 digit number, a forward slash and a 4 digit number
# which is at the end of the string.
# r'\s*[a-zA-Z,\s]+\s*' means find a space which occurs 0 or more times,
# then either a-z, A-Z, a comma or a space, at least once, followed by
# an optional space.

#Regex3
MyStr = '19960705'
match = re.search(r"19|20\d\d+[01]\d{1}[0-3]\d{1}",MyStr)
match.group()

#grouping regex patterns
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

match.group(0) #no grouping

match = re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)",MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))

#Finding all matches
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) 
for email in emails:
    print(email)

#Finding in files
f = open('../data/TestOaksData.csv', 'r')
found_oaks = re.findall(r"Q[\w\s].*\s", f.read())
found_oaks
for name in found_oaks:
    print(name.replace(","," "))

#Find groups of strings & returns a list of tuples
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"
found_matches = re.findall(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+)", MyStr)
found_matches
for item in found_matches:
    print(item)

#Extracting text from webpages
import urllib3
conn = urllib3.PoolManager()
r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/')
webpage_html = r.data

type(webpage_html)

My_Data = webpage_html.decode()
print(My_Data)

pattern = r"Dr\s+\w+\s+\w+"
regex = re.compile(pattern)
for match in regex.finditer(My_Data):
    print(match.group())

New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
print(New_Data)