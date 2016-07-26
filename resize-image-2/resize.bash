#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "illegal number of parameters (file, width and height expected)"
    exit
fi

filePath=$1
width=$2
height=$3

if [[ ! $width =~ ^-?[0-9]+$ ]]; then
	echo "width should be an integer"
	exit
fi

if [[ ! $height =~ ^-?[0-9]+$ ]]; then
	echo "height should be an integer"
	exit
fi

filePath="/images/$filePath"
fileName=$(basename $filePath)

w=$(identify -format "%w" "$filePath")
h=$(identify -format "%h" "$filePath")

# only resize if needed
if (( w > width || h > height )); then
    convert "$filePath" -resize "${width}x${height}" "/tmp/$fileName"
    mv "/tmp/$fileName" "$filePath"
fi
