#!/usr/bin/env Rscript
i <- 0 #initialise i
    while(i < Inf) {
        if (i == 20) {
            break #break out of while loop
        } else {
           cat("i equals ", i, " \n")
           i <- i + 1 #updates i
        }
    }