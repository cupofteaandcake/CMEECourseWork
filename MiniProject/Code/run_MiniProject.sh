#!/usr/bin/env bash
# Script: run_MiniProject.sh
# Name: Talia Al-Mushadani
# Date: Mar-2019

echo -e "\n--- Processing data ---\n"
# run data processing script
python3 Data_Processing.py

echo -e "--- Selecting polynomials ---\n"
# run polynomial selection
Rscript Polynomial_Selection.R

echo -e "--- Fitting models ---\n" 
# run model fitting
Rscript Conditional_Selection_AND_Model_Fitting.R

echo -e "--- Making plots ---\n"
# create plots
python3 Final_Plot.py

echo -r "--- Producing latex report ---"
# compile latex report
bash CompileLatex.sh ../Write_Up/MiniProject.tex
rm *.pdf

echo -e "MiniProject Complete"
