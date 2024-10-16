#!/bin/bash

current="00_current.jpg"
path="$HOME/Wallpapers/"
current_path="$path$current"

ls $path | sort -R | tail -$N | while read file; do
	#echo "source: $file"
	#echo "target: $path" + "current.jpg"
	cp "$path$file" "$current_path"
	break
done

wal -i "$current_path" -n

#swww img "$current_path" --transition-type random --transition-step 2 --transition-fps 144
swww img "$current_path" --transition-type random

sudo cp "$current_path" /usr/share/sddm/themes/chili/assets/background.jpg
