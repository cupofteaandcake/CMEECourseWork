#!/usr/bin/env Rscript

#run a simulation that involves sampling from a population with try

# __appname__ = try.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

x <- rnorm(50) #Generate your population
doit <- function(x){
  #generates population
  x <- sample(x, replace = TRUE)
  if(length(unique(x)) > 30) {#only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique points!")
  }
}

## Try using "try" with vectorization:
result <- lapply(1:100, function(i) try(doit(x), FALSE))

## Or using a for loop:
result <- vector("list", 100) #Preallocate/Initialize
for(i in 1:100) {
  result[[i]] <- try(doit(x), FALSE)
}