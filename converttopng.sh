#!/bin/bash
ROOTPATH=`pwd`
ORIGINAL_IFS=$IFS

#Remove files and directories like .AppleDouble
for i in `find "$ROOTPATH" -name ".*"`
do
	rm -rf $i
	echo "deleted $i"
done

#Go through the directory tree depth first and rename paths with whitespace to _
#takes two parameters root path and file\folder
function removewhitespace {
	IFS=$'\n'
	if [ -d "$1/$2" ]; then
		for file in `ls $1"/"$2`; do
			removewhitespace $1"/"$2 $file
		done 
	fi
	
	file=$(echo $2 | tr A-Z a-z | tr ' ' _ | replace ' ' '\ ')
	
        mv "$1/$2" $1"/"$file
	echo "$1/$2 moved to $1/$file"
	return 0
}

removewhitespace $ROOTPATH .

#convert files to png
for i in `find "$ROOTPATH" -name "*.jpg"`
do
	FILE=$i".png"
	convert $i -compress BZip -quality 9 $FILE
	echo "converted $i"
	rm $i
done

echo "finished"

IFS=$ORIGINAL_IFS
