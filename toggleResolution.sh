#!/bin/bash

RESOLUTION=`xrandr -q -d 0:0 | grep current | sed 's/.*current \([0-9]* x [0-9]*\).*$/\1/'`
echo "Resolution: ${RESOLUTION}"

if [[ ${RESOLUTION} == "4096 x 2160" ]] ; then
   echo "Setting resolution  1920 x 1080"
   xrandr -d 0:0 -s 1920x1080
else 
   echo "Setting resolution 4096 x 2160"
   xrandr -d 0:0 -s 4096x2160
fi
