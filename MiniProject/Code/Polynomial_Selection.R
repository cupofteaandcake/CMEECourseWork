require(ggplot2)
require(stats)

biotraits <- read.csv('../Data/condensed_biotraits.csv')

uniq <- unique(unlist(biotraits$FinalID))

#initial plotting of every trait
for (i in 1:length(uniq)){
  selectedtraits <- subset(biotraits, FinalID == uniq[i])
  traitvalueselected <- unique(selectedtraits$OriginalTraitName)
    pdf(file = paste("../Results/Data_Exploration/Exploration_", uniq[i], ".pdf", sep=""))
    print(qplot(x = ConTemp, y = OriginalTraitValue, data = selectedtraits,  
              xlab = 'Consumer Temperature', ylab = traitvalueselected, shape = I(3)))
    dev.off()
}

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
