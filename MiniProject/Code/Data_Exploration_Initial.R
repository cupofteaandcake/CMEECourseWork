require(ggplot2)
require(dplyr)
require(stats)

biotraits <- read.csv('../Data/BioTraits.csv')

# selecttraits <- split(biotraits, as.factor(biotraits$DataSeriesID))
# for (i in selecttraits){
#   pdf(paste("../Results/Exploration", i, ".pdf", sep=""))
#   qplot(selecttraits[i])
# }

uniq <- unique(unlist(biotraits$FinalID))

#initial plotting of every trait
for (i in 1:length(uniq)){
  selectedtraits <- subset(biotraits, FinalID == uniq[i])
  traitvalueselected <- unique(selectedtraits$OriginalTraitName)
    pdf(file = paste("../Results/Exploration_", uniq[i], ".pdf", sep=""))
    print(qplot(x = ConTemp, y = OriginalTraitValue, data = selectedtraits,  
              xlab = 'Consumer Temperature', ylab = traitvalueselected, shape = I(3)))
    dev.off()
}

#produce empty dataframe for only IDs which recorded mass data
mass_only_selectedtraits <- data.frame(matrix(nrow = 0, ncol = 0))

#fill dataframe with data from biotraits that only has mass data
for (i in 1:length(uniq)){
  selectedtraits <- subset(biotraits, (FinalID == uniq[i]))
  mass_results <- subset(selectedtraits, (!is.na(ConMassValueSI)))
  mass_only_selectedtraits <- rbind(mass_only_selectedtraits, mass_results)
}
#generates vector of the IDs of experiments stored in mass_only_selectedtraits
mass_uniq = unique(unlist(mass_only_selectedtraits$FinalID))
#produces plots showing three linear models; 1st, 2nd & 3rd degree polynomials in terms of consumer temperature & metabolic trait value
for (i in 1:length(mass_uniq)) {
    pdf(file = paste("../Model_Comp_Results/Exploration_", mass_uniq[i], ".pdf", sep=""))
    selected_ID = subset(mass_only_selectedtraits, (FinalID == mass_uniq[i]))
    print(ggplot(selected_ID, aes(x = ConTemp, y = OriginalTraitValue)) +
            geom_smooth(method = 'lm', formula = y ~ x, aes(color = 'Linear Relationship')) +
            geom_smooth(method = 'lm', formula = y ~ poly(x, 2), aes(color = 'Quadratic Relationship')) +
            geom_smooth(method = 'lm', formula = y ~ poly(x, 3), aes(color = 'Cubic Relationship')) +
            geom_point(shape = 3) + xlab('Consumer Temperature (ºC)') + ylab(traitvalueselected) + 
            scale_colour_manual(name='', values=c('Linear Relationship'='red', 'Quadratic Relationship'='blue', 'Cubic Relationship'='green'), guide='legend'))
    dev.off()
}

linear = lm(formula = OriginalTraitValue ~ ConTemp, data = mass_only_selectedtraits)
quadratic = lm(formula = OriginalTraitValue ~ poly(ConTemp, 2), data = mass_only_selectedtraits)
cubic = lm(formula = OriginalTraitValue ~ poly(ConTemp, 3), data = mass_only_selectedtraits)
AIC_df = AIC(linear, quadratic, cubic)
