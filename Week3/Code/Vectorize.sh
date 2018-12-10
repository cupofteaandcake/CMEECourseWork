#!/usr/bin/env bash

# Script that runs the 4 vectorize scripts and times how long they take to run

# Vectorize1.R
time Rscript Vectorize1.R

# Vectorize1.py
time python3 Vectorize1.py

# Vectorize2.R
time Rscript Vectorize2.R

# # Vectorize2.py
time python3 Vectorize2.py