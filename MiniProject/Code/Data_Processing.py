#imports
import pandas as pd
import scipy as sc

#import biotraits csv
biotraits = pd.read_csv("../Data/BioTraits.csv", sep=',', low_memory=False)
#subset into condensed form with only the key parameters & biologically informative details
condensed_biotraits = biotraits[['FinalID', 'OriginalTraitName', 'OriginalTraitValue', 'OriginalTraitUnit', 'Consumer', 'ConKingdom', 'ConTemp', 'ConMassValueSI']]
condensed_biotraits = condensed_biotraits[condensed_biotraits.OriginalTraitValue.notnull()]
condensed_biotraits = condensed_biotraits[condensed_biotraits.ConTemp.notnull()]
#subset further to only include the rows which contain mass data for the consumer in each experiment
condensed_mass_biotraits = condensed_biotraits[condensed_biotraits.ConMassValueSI.notnull()]

#loop to only include the experiments for which there are at least 5 data points due 
#to the 4 unknown parameters in the simplified Schoolfield model being evaluated
further_condensed_mass_biotraits = pd.DataFrame()
IDlist = condensed_mass_biotraits.FinalID.unique()
for i in IDlist:
    subset = condensed_mass_biotraits[condensed_mass_biotraits.FinalID == i]
    if subset.shape[0] >= 5 and len(subset.ConTemp.unique()) >= 5:
        further_condensed_mass_biotraits = further_condensed_mass_biotraits.append(subset)

further_condensed_mass_biotraits['ConTempK'] = further_condensed_mass_biotraits.ConTemp + 273.15
further_condensed_mass_biotraits['ConMassG'] = further_condensed_mass_biotraits.ConMassValueSI * 1000

further_condensed_mass_biotraits.to_csv('../Data/condensed_biotraits.csv', sep=',', index=False)