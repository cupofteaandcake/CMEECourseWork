#!/usr/bin/env python3

"""This script creates a dictionary called taxa_dic, in which the species in taxa are organised into sets based on their taxa"""

__appname__ = 'dictionary.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

# Write your script here:
taxa_dic = {} # initialise dictionary
for species in taxa:
        if species[1] == 'Chiroptera': #identifies all of the species which have Chiroptera listed as their taxa
                taxa_dic.setdefault('Chiroptera', []).append(species[0]) #initialises Chiroptera as a key and then appends the species to the key's list of values
        elif species[1] == 'Rodentia':
                taxa_dic.setdefault('Rodentia', []).append(species[0])
        elif species[1] == 'Afrosoricida':
                taxa_dic.setdefault('Afrosoricida', []).append(species[0])
        elif species[1] == 'Carnivora':
                taxa_dic.setdefault('Carnivora', []).append(species[0])
print(taxa_dic)
