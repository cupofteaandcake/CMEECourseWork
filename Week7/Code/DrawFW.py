#!/usr/bin/env python3

"""This script is to produce a food web from a network the script produces"""

__appname__ = 'DrawFW.py'
__author__ = 'Talia Al-Mushadani (ta1915@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code"

##imports##
import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

##functions##
def GenRdmAdjList(N = 2, C = 0.5): #N is no. of species & C is connectance (probabilty)
    """ 
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C: #outputs random ndarray
            Lnk = sc.random.choice(Ids,2).tolist() #converts array to list
            if Lnk[0] != Lnk[1]: #avoid self (e.g., cannibalistic) loops (intraspecific competition)
                ALst.append(Lnk)
    return ALst

MaxN = 30
C = 0.75

AdjL = sc.array(GenRdmAdjList (MaxN, C))
AdjL

Sps = sc.unique(AdjL) #get species ids

SizRan = ([-10,10]) #use log10 scale
Sizs = sc.random.uniform(SizRan[0],SizRan[1], MaxN)
Sizs

p.hist(Sizs)
p.hist(10 ** Sizs)
p.close('all') #close all open plots

pos = nx.circular_layout(Sps)

G = nx.Graph()
G.add_nodes_from(Sps)
G.add_edges_from(tuple(AdjL))
NodSizs = 1000 * (Sizs-min(Sizs))/(max(Sizs)-min(Sizs))
nx.draw_networkx(G, pos, node_size = NodSizs)
p.savefig("../Results/FW_Network.pdf")
p.close('all')