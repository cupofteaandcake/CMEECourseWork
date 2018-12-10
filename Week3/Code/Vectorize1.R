#!/usr/bin/env Rscript

# Desc: Comparing the time is takes to loop something instead of using a vector approach to computing

# __appname__ = Vectorize1.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
    #adds all elements in matrix togther
    Dimenions <- dim(M)
    Tot <- 0
    for (i in 1:Dimenions[1]){
        for (j in 1:Dimenions[2]){
            Tot <- Tot + M[i,j]
        }
    }
    return (Tot)
}
# Computes by running a loop and therefore will take longer (0.069s)
print("Time taken running in loop:")
print(system.time(SumAllElements(M)))

# Computes by using a vector instead and is therefore quicker (0.002s)
print("Time taken running vector:")
print(system.time(sum(M)))