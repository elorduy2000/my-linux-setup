#!/bin/bash

# Edit below to control the images transition
#export SWWW_TRANSITION_FPS=144
#export SWWW_TRANSITION_STEP=2
export SWWW_TRANSITION_TYPE=random

find "$1" \
| while read -r img; do
	echo "$((RANDOM % 1000)):$img"
done \
| sort -n | cut -d':' -f2- \
| while read -r img; do
       	if [[ "$img" != "$1" ]]; then
		swww img "$img" --transition-type random
		exit 0
	fi 
done
