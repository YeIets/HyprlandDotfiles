#!/usr/bin/bash


_startServices(){

	for item in "${Services[@]}"; do

		echo -e "${GREEN}"
		echo "Enabling and starting $item service"

		echo systemctl enable "$item"".service";
		if [[ "$item" == ly ]]; then
			:
        else
		    echo systemctl start "$item"".service";
        fi
	done;

	echo -e "${WHITE}"
}

Services=("ly"
		  "NetworkManager"
		  "bluetooth"
)

_startServices