#!/bin/bash
tempfolder="/media/disk2/temp"
targetfolder="/media/raid/temp/"
unrarscript="/home/marv/scripts/unrarTorrent"
cd $tempfolder

for file in `dir -d *` ; do
 unpackedFlagFile="$file/isunpacked"
 if [[ -d $file &&  ! -f $unpackedFlagFile ]] ; then 
  echo "Unpacking $unpackedFlagFile"
  fullpath="$tempfolder/$file"
  $unrarscript $fullpath $targetfolder
  touch $unpackedFlagFile
  echo "Done unpacking!"
 fi
done
