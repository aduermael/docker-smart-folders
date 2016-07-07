#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "illegal number of parameters (width and height expected)"
    exit
fi

width=$1
height=$2

if [[ ! $width =~ ^-?[0-9]+$ ]]; then
	echo "width should be an integer"
	exit
fi

if [[ ! $height =~ ^-?[0-9]+$ ]]; then
	echo "height should be an integer"
	exit
fi

# no -r option given, so subdirectories are not considered
inotifywait -r -m --timefmt '%d/%m/%y %H:%M' --format '%T %w %:e %f' \
--event create --event moved_to "/images" | while read date time dir event file; do

echo $event - $file - $time

if [ "$event" == "CREATE" ]; then
	filePath="${dir}${file}"

	w=$(identify -format "%w" "$filePath")
	h=$(identify -format "%h" "$filePath")

	# only resize if needed
	if (( w > width || h > height )); then
		echo "resize "$filePath
	    convert "$filePath" -resize "${width}x${height}" "/tmp/$file"
	    mv "/tmp/$file" "$filePath"
	fi
fi

# Note:(aduermael) Docker for Mac does not support inotify move events so far.
# This was an attempt to consider them anyway, but it's not reliable... 

# elif [ "$event" == "MODIFY" ]; then
# 	if [ "$file" == ".DS_Store" ]; then
# 		echo ".DS_Store modified"
# 		for filePath in /images/*; do
# 			if [[ -f $filePath ]]; then
# 				w=$(identify -format "%w" "$filePath")
# 				h=$(identify -format "%h" "$filePath")
# 				# only resize if needed
# 				if (( w > width || h > height )); then
# 					echo "resize "$filePath
# 				    convert "$filePath" -resize "${width}x${height}" "/tmp/$file"
# 				    mv "/tmp/$file" "$filePath"
# 				fi
# 			fi
# 		done
# 	fi
# fi

done