#!/bin/bash
ROOT="/media/windows/Webcam"
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")
TIME=$(date +"%T")
LATESTFILE=$ROOT"/latest.jpeg"
SOURCEDIR="/home/hildegunn"
LOGFILE=${SOURCEDIR}"/webcam.log.gz"

function log {
  echo "$(date)  ${1}" | gzip >> ${LOGFILE}
}

DESTINATIONFILE=$ROOT"/"$YEAR"/"$MONTH"/"$DAY
if [ ! -d "$DESTINATIONFILE" ]; then
    log "Creating $DESTINATIONFILE"
    mkdir -p $DESTINATIONFILE 
fi

IMAGES=$(ls ${SOURCEDIR}/Image*) 
for IMAGE in ${IMAGES}
do 
   log "Found ${IMAGE}"
   FILE=`stat -c %y ${IMAGE} | sed -r 's#([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{2}:[0-9]{2}:[0-9]{2})(.*)#\4#g'`
   FILE=$DESTINATIONFILE"/"$FILE".jpeg"
   log "Saving to ${FILE}"
   STAMP=`stat -c %y ${IMAGE} | sed -r 's#([0-9]{4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{2}:[0-9]{2}:[0-9]{2})(.*)#\4 \3.\2.\1#g'`
   log "Stamping $IMAGE and saving to $FILE"
   convert -fill white -box '#00000080' -gravity South -pointsize 40 -annotate +0+5 "${STAMP}" ${IMAGE} ${FILE}
   rm ${IMAGE}
done

if [ -f "$FILE" ]; then
  rm $LATESTFILE
  ln -s $FILE $LATESTFILE
  scp -P 27897 $FILE root@computerlove.dyndns.org:/var/www/holkestadcam.jpeg
else 
  log "No image found"
fi

