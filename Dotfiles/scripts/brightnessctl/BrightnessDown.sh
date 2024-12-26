#!/usr/bin/bash

### Author: YeIets (Github) 
### Desc: Shell script to put a minimum limit when decreasing the brightness
### aswell as sending a notification for


qty=5

current=$(brightnessctl -d intel_backlight g)

if [[ current -eq 1 ]]; then
	notify-send -e "Brightness set to the minimum."
else
	brightnessctl s $qty%- -n 0
	notify-send -e "Brightness decreased by $qty%."
fi


echo $current




