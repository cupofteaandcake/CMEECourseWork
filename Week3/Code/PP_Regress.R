#!/usr/bin/env Rscript

## Script that plots a recreation of Samraat's graph and 
## calculates the results of analysis of each linear 
## regression in the graph

# appname = PP_Regress.R
# author = Talia Al-Mushadani
# version = 0.0.1
# license = license for this code

rm(list = ls())
require(ggplot2)
require(dplyr)
require(tidyr)
require(plyr)

#reads csv
MyDF <- read.csv('../Data/EcolArchives-E089-51-D1.csv')

names(MyDF)

# mg_to_g <- function(MyDF){
#   for (i in 1:nrow(MyDF)){
#     if (MyDF$Prey.mass.unit[i,] == 'mg'){
#       MyDF$Prey.mass[i,] <- MyDF$Prey.mass[i,] / 1000
#     }
#   }
#   return(MyDF)
# }
# 
# mg_to_g(MyDF)

#change prey mass from mg to g
ppd <- MyDF %>% rowwise() %>% mutate(Prey.mass = ifelse(Prey.mass.unit == 'mg', 
                                                        Prey.mass/1000, Prey.mass))
#plots Samraat's graph
pdf('../Results/PP_Regress_plot.pdf', width = 8.3, height = 11.7)
Plot <- qplot(Prey.mass, Predator.mass, data = ppd, 
              colour = Predator.lifestage, shape = I(3), size = I(2), 
              xlab = 'Prey mass in grams', ylab = 'Predator mass in grams', log = ('xy'))
Plot + theme_bw() + facet_grid(MyDF$Type.of.feeding.interaction ~ .) +
  theme(legend.title = element_text(face = "bold"), legend.position = "bottom",
        plot.margin = unit(c(1,4,1,4), 'cm')) + geom_smooth(method = 'lm', 
                                                            fullrange = TRUE) + guides(colour = guide_legend(nrow = 1))
graphics.off()

#groups data by feeding interaction & predator lifestage and then produces linear models
list_reg <- dlply(ppd, .(Type.of.feeding.interaction, Predator.lifestage), 
                  function (x) lm(Predator.mass ~ Prey.mass, 
                  data = x))
#extracts the statistics from the models and adds them to a data frame
out <- ldply(list_reg, function (x){
  slope <- summary(x)$coefficients[1]
  intercept <- summary(x)$coefficients[2]
  p_value <- summary(x)$coefficients[8]
  r_squared <- summary(x)$r.squared
  data.frame(slope, intercept, r_squared, p_value)
  })
#extracts the f-statistic and adds to the data frame
f_statistic <- ldply(list_reg, function (x) summary(x)$fstatistic[1])
out <- merge(out, f_statistic, by = c('Type.of.feeding.interaction', 
                                      'Predator.lifestage'), all = TRUE)
#changes column names
names(out)[7] <- 'F.statistic'
names(out)[6] <- 'p.value'

#writes data frame to csv
write.csv(out, '../Results/PP_Regress_Results.csv', row.names = FALSE, quote = FALSE)