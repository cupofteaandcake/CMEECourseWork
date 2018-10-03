#!/bin/bash
# Script: csvtospace.sh
# Desc: substitute the commas in the files with spaces
# saves the output into a space-separated text file
# Date: Oct 2018

echo "Creating a space delimited version of $1 ..."
cat $1 | tr -s "," " " >> $1.txt
echo "Done!"
exit