#!/bin/bash

path="/home/resilente/Wallpapers/"
current="_current.jpg"

ls $path | sort -R | tail -$N | while read file: do
	cp "$path$file" "$path$current"
done

#swww img "$path$current" --transition-trype random --transition-step 2 --transition-fps 144
swww img "$path$current" --transition-trype random