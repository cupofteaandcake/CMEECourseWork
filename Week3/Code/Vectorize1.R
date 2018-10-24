#!/usr/bin/env Rscript
## Comparing the time is takes to loop something instead of using a vector approach to computing

M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
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
print(system.time(SumAllElements(M)))

# Computes by using a vector instead and is therefore quicker (0.002s)
print(system.time(sum(M)))
