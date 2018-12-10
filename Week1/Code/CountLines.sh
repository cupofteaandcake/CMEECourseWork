#!/usr/bin/env bash

# Author: Talia Al-Mushadani (ta1915@imperial.ac.uk)
# Script: CountLines.sh
# Desc: script to count lines in a file
# Arguments: file name
# Date: Oct 2018

NumLines = `wc -l < $1`
echo "The file $1 has $NumLines lines"
echo