#!/bin/zsh


#QUIT ALL WAYBAR INSTANCES
killall waybar


#LOAD CONFIG FILE BASED ON USERNAME

if [[ $USER = "dora" ]]
then
	waybar -c ~/.config/waybar/config.jsonc & -s ~/.config/waybar/style.css
else
	waybar &
fi