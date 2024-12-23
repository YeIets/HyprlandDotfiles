#!/usr/bin/bash
clear

configDir="$HOME/.config/"
directories="$HOME/HyprlandDotfiles/Dotfiles/Config/"

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


#Checks if a config directory exist inside of .config
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

#Checks if all the directories exist in .config and creates the ones that doesnt
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

_moveFiles(){
	for item in "${Directories[@]}"; do
		mv "${dirs}""$item"/* "{$configDir}"
	done
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
    read -p "DO YOU WANT TO START THE INSTALLATION NOW? (Yy/Nn): " yn
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
)

#Synchronize package database
sudo pacman -Syu
echo

#Check and install all the packages
_installPackages "${Packages[@]}"
echo

#Check for config directories and create them if they dont exist
_createDirectories "${Directories[@]}"
echo

#Move config files to .config folder
_moveFiles "${Directories[@]}"
