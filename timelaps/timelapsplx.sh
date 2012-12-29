#!/bin/bash
DIR=$1
VIDEO=${DIR}/video.mp4
if [ -f "${VIDEO}" ]
then
   echo "${VIDEO} exists"
else
   STAMPDIR=${DIR}/timelaps
   mkdir $TEMPDIR
   I=0
   for image in ${DIR}/*
   do
      if [ ! -f ${image} ]
      then
         STAMP=`stat -c %y $image | sed -r 's#([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{2}:[0-9]{2}:[0-9]{2})(.*)#\3.\2.\1 \4#g'`
         convert -fill white -box '#00000080' -gravity South -pointsize 40 -annotate +0+5 "${STAMP}" $image $STAMPDIR/img$(printf %03d $I).jpeg
         I=$(($I+1))
      fi
   done
   cd $STAMPDIR
   ffmpeg -f image2 -r 15 -i img%03d.jpeg -vcodec libx264 -vpre hq -crf 25 ${VIDEO} 
fi
