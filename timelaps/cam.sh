#!/bin/bash
ROOT="/media/windows/Webcam/"
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")
TIME=$(date +"%T")
LATESTFILE=$ROOT"latest.jpeg"
SOURCEDIR="/home/hildegunn"

function mkdirIfNonExisting {
  if [ ! -d "$1" ]; then
    echo "Creating $FILE"
    mkdir $FILE
  fi
}
DESTINATIONFILE=$ROOT"/"$YEAR
mkdirIfNonExisting $DESTINATIONFILE
DESTINATIONFILE=$DESTINATIONFILE"/"$MONTH
mkdirIfNonExisting $DESTINATIONFILE
DESTINATIONFILE=$DESTINATIONFILE"/"$DAY
mkdirIfNonExisting $DESTINATIONFILE

for IMAGE in ${SOURCEDIR}/Image*.jpg
do 
   FILE=`stat -c %y ${IMAGE} | sed -r 's#([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{2}:[0-9]{2}:[0-9]{2})(.*)#\4#g'`
   FILE=$DESTINATIONFILE"/"$FILE".jpeg"
   STAMP=`stat -c %y ${IMAGE} | sed -r 's#([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{2}:[0-9]{2}:[0-9]{2})(.*)#\4 \3.\2.\1#g'`
   echo "Stamping $IMAGE and saving to $FILE"
   convert -fill white -box '#00000080' -gravity South -pointsize 40 -annotate +0+5 "${STAMP}" ${IMAGE} ${FILE}
   rm ${IMAGE}
done

if [ -f "$FILE" ]; then
  rm $LATESTFILE
  ln -s $FILE $LATESTFILE
  scp -P 27897 $FILE root@computerlove.dyndns.org:/var/www/holkestadcam.jpeg
fi

