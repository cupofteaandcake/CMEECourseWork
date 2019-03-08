#imports
import pandas as pd
import scipy as sc
import matplotlib.pyplot as plt

#import in Results.csv from Results folder and 
#data for example thermal performance curve from condensed_biotraits.csv in Data folder

results = pd.read_csv('../Results/Results.csv', sep=',')

#produce barplot of the number of times each model was the best fitting for the data

models = results['Selected_Model'].value_counts().tolist()
label = results['Selected_Model'].value_counts().keys().tolist()
index = sc.arange(3)
fitting_results = plt.figure(figsize=(7,9))
plt.bar(x=index, height=models, width=0.5, color=['#FE6100', '#785EF0', '#DC267F'])
#plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1)
plt.xlabel('Models', fontsize=9)
plt.ylabel('Number of times model was evaluated as the best fit', fontsize = 11)
plt.xticks(index, label, fontsize=9, rotation=30)
plt.title('Evaluation of the Best Model for Thermal Performances Curves', fontsize=11)
fitting_results.tight_layout()
fitting_results.savefig('../Results/best_model_evaluation.pdf')

#produce line plot which displays what a perfect example of a thermal performance curve looks like, annotated with
#the NLLS starting parameters
##complete if enough time on Thursday/Friday