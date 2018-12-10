#!/usr/bin/env bash
#
#Script that runs and profiles LV1.py, LV2.py, LV3.py & LV4.py

#run LV1.py
echo "%run LV1.py" | ipython3
python3 -m cProfile -s cumtime LV1.py 2>&1 | head -20

#run LV2.py with optomised parameters
echo "%run LV2.py 1 0.15 1.5 0.5 40" | ipython3
python3 -m cProfile -s cumtime LV2.py 1 0.15 1.5 0.5 2>&1 | head -20

#run LV3.py
echo "%run LV3.py 1 0.15 1.5 0.5 40" | ipython3
python3 -m cProfile -s cumtime LV3.py 1 0.15 1.5 0.5 2>&1 | head -20

#run LV4.py
echo "%run LV4.py 1 0.15 1.5 0.5 40" | ipython3
python3 -m cProfile -s cumtime LV4.py 1 0.15 1.5 0.5 2>&1 | head -20