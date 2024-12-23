#!/usr/bin/bash

#Enables and starts services trhough systemctl 
_startServices(){
	for item in "${Services[@]}"; do

		echo -e "${GREEN}"
		echo "Enabling and starting $item service"

	done;

	echo -e "${WHITE}"
}

RED='\e[31m'
WHITE='\e[0m'
GREEN='\e[32m'
BLUE='\e[34m'


Services=("ly"
		  "NetworkManager"
		  "bluetooth"
)

_startServices