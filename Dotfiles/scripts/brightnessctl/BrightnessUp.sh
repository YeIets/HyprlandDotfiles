#!/usr/bin/bash

### Author: YeIets (Github) 
### Desc: Shell script to increase the brightness of the monitor and sending a notification for it

qty=5
brightnessctl s $qty%+

notify-send -e "Brightness increased by $qty%"
