#!/usr/bin/env Rscript

#This function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula
#
#height = distance * tan(radius)
#
#ARGUMENTS
#input_file: name of input csv file
#degrees: The angle of elevation of tree
#distance: The distance from base of tree (e.g. metres)
#
#OUTPUT
#The heights of the tree, same units as "distance"

# __appname__ = get_TreeHeight.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

#Function
TreeHeight <- function(degrees, distance){
    #calculates tree height using trig
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))

    return (height)
}

args = commandArgs(trailingOnly = TRUE)
input_csv <- paste('..','Data',args[1], sep = "/")
TreeData <- read.csv(input_csv)
Tree.height.m <- TreeHeight(TreeData$Angle.degrees, TreeData$Distance.m)
TreeDataResult <- cbind(TreeData, Tree.height.m)
output.name <- gsub('.csv', '', args[1])
output.file1 <- paste('..','Results',output.name, sep = "/")
output.file2 <- paste(output.file1,'.csv', sep = "")
write.csv(TreeDataResult, file = output.file2)