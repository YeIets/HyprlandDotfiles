#!/usr/bin/bash

Services=("ly"
		  "NetworkManager"
		  "bluetooth"
)

echo "${Services[2]}"".service";

sudo systemctl restart "${Services[2]}"".service";
sudo systemctl restart "${Services[1]}"".service";


