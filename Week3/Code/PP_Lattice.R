#!/usr/bin/env Rscript

# Script produces pdf lattice graphs and calculates a csv file of mean and median values

# __appname__ = PP_Lattice.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

library(lattice)
library(dplyr)

## read data
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

## lattice plot of log predator mass per type of feeding interaction
pdf('../Results/Pred_Lattice.pdf', 11.7, 8.3)
densityplot(~log(MyDF$Predator.mass) | MyDF$Type.of.feeding.interaction)
graphics.off()

## lattice plot of log prey mass per type of feeding interaction
pdf('../Results/Prey_Lattice.pdf', 11.7, 8.3)
densityplot(~log(MyDF$Prey.mass) | MyDF$Type.of.feeding.interaction)
graphics.off()

## lattice plot of log prey/predator mass per type of feeding interaction
pdf('../Results/SizeRatio_Lattice.pdf', 11.7, 8.3)
densityplot(~log(MyDF$Prey.mass/MyDF$Predator.mass) | MyDF$Type.of.feeding.interaction)
graphics.off()

dplyr::tbl_df(MyDF)

MeanMedianRatioDF <- MyDF %>%
    group_by(Type.of.feeding.interaction) %>%
    summarise(Pred.Mean = mean(Predator.mass), Pred.Median = median(Predator.mass), Prey.Mean = mean(Prey.mass),
            Prey.Median = median(Prey.mass)) %>% 
    mutate(Size.Ratio.Mean = (cumsum(Prey.Mean)/cumsum(Pred.Mean)), 
           Size.Ratio.Median = (cumsum(Prey.Median)/cumsum(Pred.Median)))

write.csv(MeanMedianRatioDF, file = "../Results/PP_Results.csv", row.names = FALSE)