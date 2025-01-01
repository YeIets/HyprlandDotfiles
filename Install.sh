#!/usr/bin/bash
clear

configDir="$HOME/.config/"
dirsPath="$HOME/HyprlandDotfiles/Dotfiles/"
font1URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Agave.zip"
font2URL="https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf"
yayURL="https://aur.archlinux.org/yay.git"
currentDir=$(pwd)

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
		echo -e "${GREEN}"
		echo "All packages already installed";
		return;
	fi;

	echo -e "${RED}"
	printf "Packages not installed: %s \n" "${toInstall[@]}";
	echo -e "${GREEN}"
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

		echo -e "${GREEN}"
		echo "All directories exist";
		return;
	fi;

	echo -e "${RED}"
	echo "Config directories not found for: ${toCopy[@]} ";

	echo -e "${GREEN}"
	echo "Proceeding to create config directories for: ${toCopy[@]} . . .";

	echo -e "${WHITE}"

	for item in "${toCopy[@]}"; do
		mkdir "${configDir}""$item"
	done
}

#Copy dotfiles from cloned repo to .config user's folder
_copyFiles(){
	for item in "${Directories[@]}"; do
		cp -rf "${dirsPath}""$item"/* "$configDir""$item"
	done
}

#Enables and starts services trhough systemctl 
_startServices(){

	for item in "${Services[@]}"; do

		echo -e "${GREEN}"
		echo "Enabling and starting $item service"

		sudo systemctl enable "$item"".service";
		if [[ "$item" == ly ]]; then
			:
		else
			sudo systemctl start "$item"".service";
		fi
	done;

	echo -e "${WHITE}"
}

_installFont(){
	#Downloads AgaveNerdFont with wget	
	wget $font1URL
	wget $font2URL
	condition="$(ls /usr/local/share | grep fonts )" #Checks if fonts folder exists

	if [[ -n "$condition" ]]; then
		#Unzips the fonts in the folder
		echo "Fonts folder found"
		sudo unzip $currentDir/Agave.zip -d /usr/local/share/fonts
		rm $currentDir/Agave.zip
		return;
	fi;

	#Creates the folder and unzips the fonts
	echo "Fonts folder NOT found, creating font folder at /usr/local/share/"
	sudo mkdir /usr/local/share/fonts

	#Moves Noto Font to Fonts
	sudo mv $currentDir/NotoColorEmoji.ttf /usr/local/share/fonts
	sudo unzip $currentDir/Agave.zip -d /usr/local/share/fonts
	rm Agave.zip

	fc-cache
}

_installYay(){
	git clone $yayURL
	cd $currentDir/yay/
	makepkg -si
}

_installPackagesYay(){
	for item in "${YayPackages[@]}"; do
		yay -S --noconfirm $item
	done;
}

#COLORS

RED='\e[31m'
WHITE='\e[0m'
GREEN='\e[32m'
BLUE='\e[34m'



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
		  "hypridle"
		  "wpaperd"
		  "xdg-desktop-portal-hyprland"
		  "brightnessctl"
		  "alacritty"
		  "rofi-wayland"
		  "libadwaita"
		  "ly"
		  "file-roller"
		  "thunar"
		  "thunar-archive-plugin"
		  "file-roller"
		  "vivaldi"
		  "waybar"
		  "pavucontrol"
		  "bluez"
		  "networkmanager"
		  "gammastep"
		  "swaync"
		  "btop"
		  "gum"
		  "wget"
		  "zip"
		  "unzip"
		  "bat"
		  "macchina"
)

YayPackages=("Hyprshot"
			 "bluetuith"
			 "rofimoji"
)

Directories=("alacritty"
             "gammastep"
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

Services=("ly"
		  "NetworkManager"
		  "bluetooth"
)

#Synchronize package database
sudo pacman -Syu
echo

#Check and install all the packages
_installPackages "${Packages[@]}"
echo

_installYay
_installPackagesYay

#Installs AgaveNerdFont  // IS THE ONLY FONT USED IN THE WHOLE SYSTEM, YOU CAN CHANGE IT BY EDITING THE CONFIG FILE FOR EACH PACKAGE
_installFont
echo

#Check for config directories and create them if they dont exist
_createDirectories "${Directories[@]}"
echo

#Asking for confirmation to copy files
echo -e "${RED}"
echo "The script will copy the config files to your .config directory, IT WILL NOT CREATE A BACKUP"
echo "Creating a backup of your .config files is recommended."
echo -e "${WHITE}"

decision=$(gum choose "YES, let the script do it" "NO, let me create my backup")

if [[ "$decision" == "YES, let the script do it" ]]; then

	_copyFiles
	echo -e "${GREEN}"
	echo "Config files copied succesfuly"
	echo -e "${WHITE}"

elif [ "$decision" == "NO, let me create my backup" ]; then
	echo -e "${GREEN}"
	echo "Finalizing setup"
	echo -e "${WHITE}"
else
	echo -e "${RED}"
	echo ":: Setup Canceled"
	exit 130
fi
echo

#Asking for confirmation to enable and start services
echo -e "${RED}"
echo "Do you want to enable and start the services yourself or let the script do it? "
echo -e "${WHITE}"

decision=$(gum choose "YES, let the script do it" "NO, I'll do it myself")

if [[ "$decision" == "YES, let the script do it" ]]; then

	_startServices

elif [ "$decision" == "NO, I'll do it myself" ]; then
    	echo -e "${GREEN}"
		echo "Finalizing setup"
		echo -e "${WHITE}"
else
	echo -e "${RED}"
	echo ":: Setup Canceled"
	exit 130
fi

#END
echo -e "${GREEN}"
cat	<<"EOF"
  ______  __    __   ______  ________   ______   __         ______  ________  ______   ______   __    __ 
|      \|  \  |  \ /      \|        \ /      \ |  \       /      \|        \|      \ /      \ |  \  |  \
 \$$$$$$| $$\ | $$|  $$$$$$\\$$$$$$$$|  $$$$$$\| $$      |  $$$$$$\\$$$$$$$$ \$$$$$$|  $$$$$$\| $$\ | $$
  | $$  | $$$\| $$| $$___\$$  | $$   | $$__| $$| $$      | $$__| $$  | $$     | $$  | $$  | $$| $$$\| $$
  | $$  | $$$$\ $$ \$$    \   | $$   | $$    $$| $$      | $$    $$  | $$     | $$  | $$  | $$| $$$$\ $$
  | $$  | $$\$$ $$ _\$$$$$$\  | $$   | $$$$$$$$| $$      | $$$$$$$$  | $$     | $$  | $$  | $$| $$\$$ $$
 _| $$_ | $$ \$$$$|  \__| $$  | $$   | $$  | $$| $$_____ | $$  | $$  | $$    _| $$_ | $$__/ $$| $$ \$$$$
|   $$ \| $$  \$$$ \$$    $$  | $$   | $$  | $$| $$     \| $$  | $$  | $$   |   $$ \ \$$    $$| $$  \$$$
 \$$$$$$ \$$   \$$  \$$$$$$    \$$    \$$   \$$ \$$$$$$$$ \$$   \$$   \$$    \$$$$$$  \$$$$$$  \$$   \$$
                                                                                                        
  ______    ______   __       __  _______   __        ________  ________  ________                      
 /      \  /      \ |  \     /  \|       \ |  \      |        \|        \|        \                     
|  $$$$$$\|  $$$$$$\| $$\   /  $$| $$$$$$$\| $$      | $$$$$$$$ \$$$$$$$$| $$$$$$$$                     
| $$   \$$| $$  | $$| $$$\ /  $$$| $$__/ $$| $$      | $$__       | $$   | $$__                         
| $$      | $$  | $$| $$$$\  $$$$| $$    $$| $$      | $$  \      | $$   | $$  \                        
| $$   __ | $$  | $$| $$\$$ $$ $$| $$$$$$$ | $$      | $$$$$      | $$   | $$$$$                        
| $$__/  \| $$__/ $$| $$ \$$$| $$| $$      | $$_____ | $$_____    | $$   | $$_____                      
 \$$    $$ \$$    $$| $$  \$ | $$| $$      | $$     \| $$     \   | $$   | $$     \                     
  \$$$$$$   \$$$$$$  \$$      \$$ \$$       \$$$$$$$$ \$$$$$$$$    \$$    \$$$$$$$$                     
EOF
echo
echo -e "${RED}"
echo "You may now start the greeter with systemctl enable --now ly.service"
echo -e "${WHITE}"