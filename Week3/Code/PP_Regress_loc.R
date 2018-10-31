#!/usr/bin/env Rscript

## Script that calculates the results of analysis of each linear 
## regression when location is added to PP_Regress.R as an
## additional variable by which to subset the data

# appname = PP_Regress_loc.R
# author = Talia Al-Mushadani
# version = 0.0.1
# license = license for this code

rm(list = ls())
require(ggplot2)
require(dplyr)
require(tidyr)
require(plyr)

#read csv in to R
MyDF <- read.csv('../Data/EcolArchives-E089-51-D1.csv')

names(MyDF)

#change prey mass from mg to g
ppd <- MyDF %>% rowwise() %>% mutate(Prey.mass = ifelse(Prey.mass.unit == 'mg', 
                                                        Prey.mass/1000, Prey.mass))

#group all data by feeding interaction and predator lifestage, and then produce linear models
list_reg <- dlply(ppd, .(Type.of.feeding.interaction, Predator.lifestage, Location), 
                  function (x) lm(Predator.mass ~ Prey.mass, 
                  data = x))
#extracts all statistics from the models and adds them to a data frame
out <- ldply(list_reg, function (x){
  slope <- summary(x)$coefficients[1]
  intercept <- summary(x)$coefficients[2]
  p_value <- summary(x)$coefficients[8]
  r_squared <- summary(x)$r.squared
  data.frame(slope, intercept, r_squared, p_value)
  })

#extracts the f-statistic
f_statistic <- ldply(list_reg, function (x) summary(x)$fstatistic[1])
out <- merge(out, f_statistic, by = c('Type.of.feeding.interaction', 
                                      'Predator.lifestage', 'Location'), all = TRUE)
#changes names a data frame columns
names(out)[8] <- 'F.statistic'
names(out)[7] <- 'p.value'

#writes csv file
write.csv(out, '../Results/PP_Regress_loc_Results.csv', row.names = FALSE, quote = FALSE)