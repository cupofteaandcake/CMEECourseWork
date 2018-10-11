#!/usr/bin/env python3

"""A series of list comprehensions and loops for creating sets based on the bird data provided"""

__appname__ = 'lc1.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

## Conventional loop for creating list containing birds' latin names
birds_latin = set()
for species in birds:
    birds_latin.add(species[0]) #searches for and adds all of the first variables for each species, which is the latin name
print(birds_latin)

## Conventional loop for creating list containing birds' common names
birds_common = set()
for species in birds:
    birds_common.add(species[1]) #searches for and adds all of the second variables for each species, which is the common name
print(birds_common)

## Conventional loop for creating list containing birds' mean body masses
birds_mean_body_mass = set()
for species in birds:
    birds_mean_body_mass.add(species[2]) #searches for and adds all of the third variables for each species, which is the mean body mass
print(birds_mean_body_mass)

## List comprehension for creating list containing birds' latin names
birds_latin_lc = set([species[0] for species in birds])
print(birds_latin_lc)

## List comprehension for creating list containing birds' common names
birds_common_lc = set([species[1] for species in birds])
print(birds_common_lc)

## List comprehension for creating list containing birds' mean body masses
birds_mbm_lc = set([species[2] for species in birds])
print(birds_mbm_lc)