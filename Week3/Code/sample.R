#!/usr/bin/env Rscript

# Run a simulation that involves sampling from a population

# __appname__ = sample.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

x <- rnorm(50) #generate your population
doit <- function(x){
    #generates population
    x <- sample(x, replace = TRUE)
    if(length(unique(x)) > 30) { #only take mean if sample was sufficient
        print(paste("Mean of this sample was:", as.character(mean(x))))
    }
}

## Run 100 iterations using vectorisation:
result <- lapply(1:100, function(i) doit(x))

## Or using a for loop:
result <- vector("list", 100) #Preallocate/initialise
for(i in 1:100) {
    result[[i]] <- doit(x)
}