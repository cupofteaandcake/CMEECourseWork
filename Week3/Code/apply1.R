#!/usr/bin/env Rscript

# illustrating apply which applies the same function to rows/columns of a matrix

# __appname__ = apply1.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

## build a random matrix
M <- matrix(rnorm(100), 10, 10)

## take the mean of each row
RowMeans <- apply(M, 1, mean)
print(RowMeans)

#now the variance
RowVars <- apply(M, 1, var)
print(RowVars)

# by column
ColMeans <- apply(M, 2, mean)
print(ColMeans)