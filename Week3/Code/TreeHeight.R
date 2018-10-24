#!/usr/bin/env Rscript
#This function calculates heights of trees given distance of each tree from its base and angle to its top, using the trigonometric formula
#
#height = distance * tan(radius)
#
#ARGUMENTS
#degrees: The angle of elevation of tree
#distance: The distance from base of tree (e.g. metres)
#
#OUTPUT
#The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))

    return (height)
}

TreeData <- read.csv("../Data/trees.csv")
Tree.height.m <- TreeHeight(TreeData$Angle.degrees, TreeData$Distance.m)
TreeDataResult = cbind(TreeData, Tree.height.m)
write.csv(TreeDataResult, "../Results/TreeHts.csv")
