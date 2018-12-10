#!/usr/bin/env Rscript

# A boilerplate R script

# __appname__ = boilerplate.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

MyFunction <- function(Arg1, Arg2){

    #Statements involving Arg1, Arg2:
    print(paste("Argument", as.character(Arg1), "is a", class(Arg1)))
    print(paste("Argument", as.character(Arg2), "is a", class(Arg2)))
    
    return (c(Arg1, Arg2))
}

MyFunction(1,2) #test the function
MyFunction("Riki", "Tiki") #another test