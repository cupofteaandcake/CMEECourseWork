#!/usr/bin/env python3

"""A python script which finds the best alignment of two DNA sequences"""

__appname__ = 'align_seqs.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

# These are the two sequences to match
import csv

f = open('../Data/sample_seqs.csv', 'r')

csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
f.close()

seq2 = row[1]
seq1 = row[0]

# assign the longest sequence s1, and the shortest to s2
# l1 is the length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

def calculate_score(s1, s2, l1, l2, startpoint):
    """function that computes a score by returning the number of matches starting from arbitrary startpoint"""
    # startpoint is the point at which we want to start
    matched = "" # contains string for alignement
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            # if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # build some formatted output
    print("." * startpoint + matched)        
    print("." * startpoint + s2)
    print(s1)
    print(score)
    print("")

    return score

calculate_score(s1, s2, l1, l2, 0)
calculate_score(s1, s2, l1, l2, 1)
calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score)
my_best_align = None
my_best_score = -1

for i in range(l1):
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2
        my_best_score = z

print(my_best_align)
print(s1)
print(my_best_score)

g = open("../Data/best_alignment.txt", 'w')
csvwrite = csv.writer(g)
csvwrite.writerow([my_best_align])
csvwrite.writerow([s1])
csvwrite.writerow([my_best_score])
g.close()
