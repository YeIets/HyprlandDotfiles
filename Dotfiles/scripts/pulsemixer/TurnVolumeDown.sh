#!/usr/bin/bash

### Author: YeIets (Github) 
### Desc: Shell script to turn spotify volume down
### THIS ONLY WORKS FOR SPOTIFY, if you want to make it work for other apps make 
### sure to change the argument of grep for the name of the sink of your desired app

SINK_ID=$(pulsemixer -l | grep spotify | grep -o 'sink-input-[0-9]\+')

echo ${SINK_ID}

pulsemixer --id $SINK_ID --change-volume -5