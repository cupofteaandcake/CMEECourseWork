#!/usr/bin/env Rscript

# Script showing how to plot graphs in R

# __appname__ = How_to_plot.R
# __author__ = Talia Al-Mushadani
# __version__ = 0.0.1
# __license__ = license for this code

rm(list = ls())
graphics.off()

require(ggplot2)

MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
plot(MyDF$Predator.mass, MyDF$Prey.mass)
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass))
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass), pch=20)
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass), pch=20, xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)")

hist(MyDF$Predator.mass)
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count")
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count", col = 'lightblue', border = 'pink')

par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log(MyDF$Predator.mass), xlab = "Predator Mass (kg)", ylab = "Count", col = "lightblue", border = "pink", main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log(MyDF$Prey.mass), xlab="Prey Mass (kg)",ylab="Count", col = "lightgreen", border = "pink", main = 'prey')

hist(log(MyDF$Predator.mass), # Predator histogram
     xlab="Body Mass (kg)", ylab="Count", 
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap") 
hist(log(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors

boxplot(log(MyDF$Predator.mass), xlab = "Location", ylab = "Predator Mass", main = "Predator mass")

boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # Why the tilde?
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by location")

pdf("../Results/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
     xlab="Body Mass (kg)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
     col = rgb(0, 0, 1, 0.5), 
     add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off(); #you can also use dev.off()

qplot(Prey.mass, Predator.mass, data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = Type.of.feeding.interaction)
