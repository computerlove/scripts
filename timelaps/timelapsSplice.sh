#!/bin/bash
ROOT="/media/windows/Webcam"
YEAR=$(date -d '1 day ago' +"%Y")
MONTH=$(date -d '1 day ago' +"%m")
DAY=$(date -d '1 day ago' +"%d")

FILE=${ROOT}"/"${YEAR}"/"${MONTH}"/"${DAY}
VIDEO=${FILE}"/video.mp4"
if [ ! -f "${VIDEO}" ];
then
   /home/hildegunn/scripts/timelaps/timelapsplx.sh ${FILE}
else 
   echo "${VIDEO} exists"
fi

#TODAY=$(date +"%d")
#if [ "${TODAY}" == "29" ];
#then
#   FILE=${ROOT}"/"${YEAR}"/"${MONTH}
#   VIDEO=${FILE}"/video.mp4"
#   VIDEOFILES=`find ${FILE} -name \*.mp4 -print | sort`
#   MERGEFILES=""
#   for f in ${VIDEOFILES} ; do
#      MERGEFILES=${MERGEFILES}" -i ${f}"
#   done
#   echo "Merging files: ${MERGEFILES}"
#   echo "ffmpeg ${MERGEFILES} -vcodec copy -sameq ${VIDEO}"
#fi

