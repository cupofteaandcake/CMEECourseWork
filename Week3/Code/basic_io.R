#!/usr/bin/env Rscript
# A simple script to illustrate R input-output

# __appname__ = basic_io.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

MyData <- read.csv("../Data/trees.csv", header = TRUE) #import with headers
write.csv(MyData, "../Results/MyData.csv") #write to a new file
write.table(MyData[1,], file = "../Results/MyData.csv", append = TRUE) #append data to csv
write.csv(MyData, "../Results/MyData.csv", row.names = TRUE) #write row names
write.table(MyData, "../Results/MyData.csv", col.names = FALSE) #ignore column names