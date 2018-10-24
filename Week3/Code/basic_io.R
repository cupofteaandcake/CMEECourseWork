#!/usr/bin/env Rscript
# A simple script to illustrate R input-output

MyData <- read.csv("../Data/trees.csv", header = TRUE) #import with headers
write.csv(MyData, "../Results/MyData.csv") #write to a new file
write.table(MyData[1,], file = "../Results/MyData.csv", append = TRUE) #append data to csv
write.csv(MyData, "../Results/MyData.csv", row.names = TRUE) #write row names
write.table(MyData, "../Results/MyData.csv", col.names = FALSE) #ignore column names