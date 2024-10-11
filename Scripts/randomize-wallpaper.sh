#!/bin/bash

current="00_current.jpg"
path="/home/resilente/Wallpapers/"
current_path="$path$current"

ls $path | sort -R | tail -$N | while read file: do
	cp "$path$file" "$current_path"
done

#swww img "$path$current" --transition-trype random --transition-step 2 --transition-fps 144
swww img "$current_path" --transition-trype random