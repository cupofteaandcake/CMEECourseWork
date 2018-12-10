#!/usr/bin/env bash

# __appname__ = run_get_TreeHeight.sh
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

#calls R version of get_TreeHeight
Rscript get_TreeHeight.R trees.csv

#calls python version of get_TreeHeight
python3 get_TreeHeight.py trees.csv