#!/usr/bin/env python3

"""A series of loops and list comprehensions to create lists based on the Met Office data provided"""

__appname__ = 'lc2.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )


# Loop to create a list of month & rainfall level tuples where the rainfall was greater than 100 mm
tuples = set()
for m, w in enumerate(rainfall): #produce counter, m, for each tuple in rainfall
    if w[1] >= 100: #looks through second elements of the tuples for floats greater than, or equal to, 100 mm
        tuples.add(rainfall[m]) #adds the tuples it found to a new list, using the counter, m, to identify them
print(tuples)

# Loop to create a list of just the names of months when there was less than 50 mm of rain
months = set()
for c, l in enumerate(rainfall): #produces counter, c, for each tuple in rainfall
    if l[1] <= 50: #looks through the second element of the tuples for floats less than, or equal to, 50 mm
        months.add(rainfall[c][0]) #adds the first element (month) of every tuple identified using c to a new list
print(months)

# List comprehension to create a list of month & rainfall level tuples,
# where the rainfall level was greater than 100 mm
tuples_lc = set([rainfall[m] for m, w in enumerate(rainfall) if w[1] >= 100])
print(tuples_lc)

# List comprehension to create a list of just the names of months when there was less than 50 mm of rain
months_lc = set([rainfall[c][0] for c, l in enumerate(rainfall) if l[1] <= 50])
print(months_lc)