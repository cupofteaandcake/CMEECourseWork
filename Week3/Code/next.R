#!/usr/bin/env Rscript

# Illustrates the use of next in a loop

# __appname__ = next.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

for (i in 1:10) {
    if ((i %% 2) == 0)
        next #pass to next iteration of loop
    print(i)
}