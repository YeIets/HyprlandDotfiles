#!/usr/bin/bash
clear

userPath="$HOME"

#Cheeck if package is installed
#Returns 0 if the package passed IS found or 1 if IS NOT found

_isInstalled(){

	package="$1";
	condition="$(pacman -Qe | awk '{print $1}' | grep $package)";

	if [[ -n "$condition" ]]; then
		#Package Found
		echo 0;
		return;
	fi;
	#Package Not Found
	echo 1;
	return;	
}

#Check if the packages are installed through "_isInstalled()"
#Installs missing packages

_installPackages(){

	toInstall=();

	for pkg; do
		if [[ $( _isInstalled ${pkg} ) == 0 ]]; then
			#echo " ${pkg} already installed ";
			continue;
		fi;
		toInstall+=("${pkg}");
	done;

	if [[ "${toInstall[@]}" == "" ]]; then
		echo "All packages already installed";
		return;
	fi;

	printf "Packages not installed: %s \n" "${toInstall[@]}";
	printf "Proceeding to install %s . . . \n" "${toInstall[@]}" ;
    sudo pacman -S "${toInstall[@]}";


}


#COLORS

RED='\e[31m'
WHITE='\e[0m'
GREEN='\e[32m'



#TILE
echo -e "${RED}"
cat	<<"EOF"
 ______  __    __   ______  ________   ______   __        __        ________  _______  
|      \|  \  |  \ /      \|        \ /      \ |  \      |  \      |        \|       \ 
 \$$$$$$| $$\ | $$|  $$$$$$\\$$$$$$$$|  $$$$$$\| $$      | $$      | $$$$$$$$| $$$$$$$\
  | $$  | $$$\| $$| $$___\$$  | $$   | $$__| $$| $$      | $$      | $$__    | $$__| $$
  | $$  | $$$$\ $$ \$$    \   | $$   | $$    $$| $$      | $$      | $$  \   | $$    $$
  | $$  | $$\$$ $$ _\$$$$$$\  | $$   | $$$$$$$$| $$      | $$      | $$$$$   | $$$$$$$\
 _| $$_ | $$ \$$$$|  \__| $$  | $$   | $$  | $$| $$_____ | $$_____ | $$_____ | $$  | $$
|   $$ \| $$  \$$$ \$$    $$  | $$   | $$  | $$| $$     \| $$     \| $$     \| $$  | $$
 \$$$$$$ \$$   \$$  \$$$$$$    \$$    \$$   \$$ \$$$$$$$$ \$$$$$$$$ \$$$$$$$$ \$$   \$$	

EOF
echo -e "${WHITE}"

while true; do
    read "?DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo ":: Installation started."
            echo
        break;;
        [Nn]* ) 
            echo ":: Installation canceled"
            exit;
        break;;
        * ) 
            echo ":: Please answer yes or no."
        ;;
    esac
done

Packages=("hyprland"
		  "hyprlock"
		  "hypridl"
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

#name="hyprland"


#echo $(_isInstalled $name)

_installPackages "${Packages[@]}"

#if [[ $( _isInstalled $name ) == 0 ]]; then
#	echo "$name is installed"
#else
#	echo "$name not installed"
#fi
