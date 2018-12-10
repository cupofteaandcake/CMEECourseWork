#!/usr/bin/env Rscript

# Illustrates use of break in a loop

# __appname__ = break.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

i <- 0 #initialise i
    while(i < Inf) {
        if (i == 20) {
            break #break out of while loop
        } else {
           cat("i equals ", i, " \n")
           i <- i + 1 #updates i
        }
    }