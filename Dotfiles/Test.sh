#!/usr/bin/bash

configDir="$HOME/.config/"
directories="$HOME/GitHub/HyprlandDotfiles/Dotfiles/Config/"

_isCreated(){

	package="$1";
	condition="$(ls $configDir | grep $pkg)";

	if [[ -n "$condition" ]]; then
		#Config directory for the package Is found
		echo 0;
		return;
	fi;
	#Directory Not Found
	echo 1;
	return;	
}


_createDirectories(){

	toCopy=();

	for pkg; do
		if [[ $( _isCreated ${pkg} ) == 0 ]]; then
			#echo " ${pkg} already installed ";
			continue;
		fi;
		toCopy+=("${pkg}");
	done;

	if [[ "${toCopy[@]}" == "" ]]; then
		echo "All directories exist";
		return;
	fi;

	printf "Config directories not found for: %s \n" "${toCopy[@]}";
	printf "Proceeding to create config directories for: %s . . . \n" "${toCopy[@]}" ;

	for item in "${toCopy[@]}"; do
		mkdir "${configDir}""$item"
	done


}

Packages=("hyprland"
		  "hyprlock"
		  "hypridle"
		  "wpaperd"
		  "xdg-desktop-portal-hyprland"
		  "brightnessctl"
		  "kitty"
		  "alacritty"
		  "rofi-wayland"
		  "libadwaita"
		  "lxappearence"
		  "ly"
		  "file-roller"
		  "thunar"
		  "thunar-archive"
		  "vivaldi"
		  "waybar"
		  "pavucontrol"
		  "bluez"
		  "networkmanager"
		  "gammastep"
		  "swaync"
		  "btop"
)

Directories=("alacritty"
             "gammastep"
             "hypr"
             "hypr"
             "macchina"
             "pavucontrol"
             "rofi"
             "scripts"
             "sublime-text"
             "swaync"
             "waybar"
             "wpaperd"
			 "asdasda"
			 "bsdasd"
)




_copyDirectories "${Directories[@]}"
