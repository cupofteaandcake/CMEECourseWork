#!/usr/bin/env Rscript

# __appname__ = preallocate.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

no_allocate <- function(a){
    #doesn't preallocate a
    a <- NA
    for (i in 1:1000000) {
        a <- c(a, i)
    }
    print(a)
}
# preallocate space in RAM for any form of data
pre_allocate <- function(a){
    #preallocates a
    a <- rep(NA, 1000000)
    for (i in 1:1000000){
        a[i] = 10
    }
}

# more than 2 min
print(system.time(no_allocate(a)))

# 0.048s
print(system.time(pre_allocate(a)))