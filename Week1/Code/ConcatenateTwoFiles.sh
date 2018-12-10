#!/usr/bin/env bash

# Author: Talia Al-Mushadani (ta1915@imperial.ac.uk)
# Script: ConcatenateTwoFiles.sh
# Desc: script to merge two files together
# Arguments: two file names
# Date: Oct 2018

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3