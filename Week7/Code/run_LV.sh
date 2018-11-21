##!/usr/bin/env bash
#
#Script that runs and profiles LV1.py & LV2.py

#run LV1.py
echo "%run LV1.py" | ipython
python3 -m cProfile -s tottime LV1.py 2>&1 | head -20

#run LV2.py
echo "%run LV2.py 1 0.1 1.5 0.75 15" | ipython
python3 -m cProfile -s tottime LV2.py 2>&1 | head -20

#run LV2.py with 'optomised' parameters
echo "%run LV2.py 1 0.15 1.5 0.5 40" | ipython