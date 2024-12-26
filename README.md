# HyprlandDotfiles

This is my first time ricing hyprland, has been a fun experience.
It's pretty much themed black and white so almost any manga wallpaper or sum like that will fit pretty well. 

## Screenshots

![alt text](/Screenshots/Desktop-FloatNoti.png "Desktop Notification")
![alt text](/Screenshots/Desktop-Windows.png "Windows")
![alt text](/Screenshots/Desktop-NotiCenter.png "Notification Center")

## Installation

The installation script was made with the scenario of having a fresh archlinux minimal installation done, just clone the repo, execute the script and you're done.
If you already have your configuration and just want to try it, i'll recommend just copying the config files to your directories cause THE SCRIPT DOESN'T MAKE A BACKUP FOR YOUR CONFIGURATION. I'll implement it as soon as I can, not really a rush but I'm still learning bash and stuff.
It was also made for a laptop, your waybar may look a lil bit empty if your trying it on desktop, you can always use it as a blueprint and customize it to your liking.

### Installation (Minimal archinstall)

You need to install git, if you haven't already. You can do it with:

```
sudo pacman -Syu     #Synchronize, refresh and update packages
sudo pacman -S git   #Install git
```

Check if git is installed:

```
git #Just type "git" and it'll display some text if it's correctly installed
```

Clone this repository:

```
#It's YeIets with capital i not an l
git clone "https://github.com/YeIets/HyprlandDotfiles" 
```

Make sure you gave the file permissions before executing it or it'll throw a permission error. You can do it by:

```
#If you're in the same directory as the Install.sh
chmod u+x Install.sh
```

You can check the permissions of the file with ls.

```
ls -l #Lists the files in the current directory 
```

Then just simply run the ***Install.sh***.

```
./Path/To/Install.sh
```

If everything goes well, you should then be seeing the ly greeter, just sign in and that's it.

### Installation (Already configured machine)

You can follow the same steps for the Minimal Archinstall, remember that THE SCRIPT DOES NOT CREATE A BACKUP and it can, and WILL REWRITE THE FILES with the repo ones. I highly recommend making a backup of your own.

### Used Packages

| Package                                                            | Description           |
| ------------------------------------------------------------------ | --------------------- |
| [Alacritty](https://github.com/alacritty/alacritty)                | Terminal emulator     |
| [Bluez](https://github.com/bluez/bluez)                            | Bluetooth protocol    |
| [Bluetuith](https://github.com/darkhz/bluetuith)                   | Bluetooth TUI manager |
| [Brightnessctl](https://github.com/Hummer12007/brightnessctl)      | Brightness controller |
| [Gammastep](https://gitlab.com/chinstrap/gammastep)                | Color temperature     |
| [Hyprland](https://github.com/hyprwm/Hyprland)                     | Tiling compositor     |
| [Hyprlock](https://github.com/hyprwm/hyprlock)                     | Lockscreen            |
| [NetworkManager](https://github.com/NetworkManager/NetworkManager) | Network Manager (Duh) |
| [Rofi Wayland](https://github.com/lbonn/rofi)                      | Application Launcher  |
| [Swaync](https://github.com/ErikReider/SwayNotificationCenter)     | Notification Center   |
| [Thunar](https://github.com/xfce-mirror/thunar)                    | File Manager          |
| [Waybar](https://github.com/Alexays/Waybar)                        | Status Bar            |
| [Wpaperd](https://github.com/danyspin97/wpaperd)                   | Wallpaper Daemon      |
| [Ly](https://github.com/fairyglade/ly)                             | Greeter               |
| [Macchina](https://github.com/Macchina-CLI/macchina)               | System information    |


### Notes

- The script should work but it may be prone to errors (I'll be working on them)
- You can take a look to the script to see the full list of installed packages and remove or add some as you like.
