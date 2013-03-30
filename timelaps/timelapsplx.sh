#!/bin/bash
DIR="/media/windows/Webcam"
TEMPDIR="/tmp/timelapstemp"
FROM=$1
TO=$2
VIDEO="${DIR}/${FROM}-${TO}.mp4"

if [ "$1" == "usage" ]
then
   echo "timelapsplx.sh yyyy-mm-dd yyyy-mm-dd"
   exit 0
fi

if [ -f "${VIDEO}" ]
then
   echo "${VIDEO} exists"
else
   mkdir -p $TEMPDIR

   IMAGES=$(find ${DIR} -name "*.jpeg" -newermt ${FROM} ! -newermt ${TO} | sort)
   echo "find ${DIR} -name "*.jpeg" -newermt ${FROM} ! -newermt ${TO} | sort"

   I=0
   for image in ${IMAGES}
   do
     ln -s ${image} "${TEMPDIR}/img$(printf %05d $I).jpeg"
     I=$(($I+1))
   done
   cd $TEMPDIR
   ffmpeg -f image2 -r 15 -s svga -i img%05d.jpeg -vcodec libx264 -vpre hq -crf 25 ${VIDEO} 
   rm -rf $TEMPDIR
fi
