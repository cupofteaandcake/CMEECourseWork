## Author: Talia Al-Mushadani (ta1915)
## Script: Polynomial_Selection.R
## Date: 20/2/19
## Version: 0.0.1

rm(list=ls())
graphics.off()

#libraries
require(stats)

#read in data
biotraits <- read.csv('../Data/condensed_biotraits.csv')

#generate models
linear = lm(formula = OriginalTraitValue ~ ConTempK, data = biotraits)
quadratic = lm(formula = OriginalTraitValue ~ poly(ConTempK, 2), data = biotraits)
cubic = lm(formula = OriginalTraitValue ~ poly(ConTempK, 3), data = biotraits)

#calculate AIC value
l_AIC = AIC(linear)
q_AIC = AIC(quadratic)
c_AIC = AIC(cubic)

#find lowest AIC value (which corresponds to the best model)
min(c(l_AIC, q_AIC, c_AIC))
