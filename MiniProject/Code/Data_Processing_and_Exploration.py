#imports
import pandas as pd
import scipy as sc

#import biotraits csv
biotraits = pd.read_csv("../Data/BioTraits.csv", sep=',', low_memory=False)
#subset into condensed form with only the key parameters & biologically informative details
condensed_biotraits = biotraits[['FinalID', 'OriginalTraitName', 'OriginalTraitValue','Habitat', 'Climate', 'ConKingdom', 'ConStage', 'ConTemp', 'ConMassValueSI']]
#subset further to only include the rows which contain mass data for the consumer in each experiment
condensed_mass_biotraits = condensed_biotraits[condensed_biotraits.ConMassValueSI.notnull()]

#loop to only include the experiments for which there are at least 6 data points due 
#to the 4 parameters in the 3 models being evaluated
further_condensed_mass_biotraits = pd.DataFrame()
IDlist = condensed_mass_biotraits.FinalID.unique()
for i in IDlist:
    subset = condensed_mass_biotraits[condensed_mass_biotraits.FinalID == i]
    if subset.shape[0] >= 6:
        further_condensed_mass_biotraits = further_condensed_mass_biotraits.append(subset)

further_condensed_mass_biotraits.to_csv('../Data/condensed_biotraits.csv', sep=',', index=False)