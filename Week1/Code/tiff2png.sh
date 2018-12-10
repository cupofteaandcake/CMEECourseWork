#!/usr/bin/env bash

# Author: Talia Al-Mushadani (ta1915@imperial.ac.uk)
# Script: tiff2png.sh
# Desc: script to convert .tiff file to a .png file
# Arguments: .tif file
# Date: Oct 2018

for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).jpg"; 
    done