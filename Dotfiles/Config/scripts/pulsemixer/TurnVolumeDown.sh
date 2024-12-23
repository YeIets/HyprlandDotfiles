#!/usr/bin/zsh

SINK_ID=$(pulsemixer -l | grep spotify | grep -o 'sink-input-[0-9]\+')

echo ${SINK_ID}

pulsemixer --id $SINK_ID --change-volume -5 --max-volume 100