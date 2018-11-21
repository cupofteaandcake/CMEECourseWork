#!/usr/bin/env python3

"""This script is to produce a data-frame containing the kingdom, 
phylum & species data extracted using regex from blackbirds.txt"""

__appname__ = 'blackbirds.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

import re
import pandas as pd

# Read the file (using a different, more python 3 way, just for fun!)
with open('../Data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string
print(text)

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.

# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (easier!), or a single one (harder!)

kingdom = re.findall(r"Kingdom\s([A-Z]{1}\w+)", text)
phylum = re.findall(r"Phylum\s([A-Z]{1}\w+)", text)
species = re.findall(r"Species\s([A-Z]{1}\w+\s{1}\w+)", text)

taxonomic_list = pd.DataFrame(
    {'Kingdom': kingdom,
    'Phylum': phylum,
    'Species': species
    })
print(taxonomic_list)