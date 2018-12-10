#!/usr/bin/env Rscript

#illustrates the use of apply

# __appname__ = apply2.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

SomeOperation <- function(v){
    #does an operation
    if (sum(v) > 0){
        return (v * 100)
    }
    return(v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))