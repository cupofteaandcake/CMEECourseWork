#!/usr/bin/env Rscript

# Script shows how to replicate something

# __appname__ = replicate.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

replicate(10, runif(5))
#produces 10 sets (columns) of 5 uniformly-distributed random numbers