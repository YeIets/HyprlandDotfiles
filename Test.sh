#!/usr/bin/bash

#
echo -e "${RED}"
echo "Do you want to enable and start the services yourself or let the script do it? "
echo -e "${WHITE}"

decision=$(gum choose "YES, let the script do it" "NO, I'll do it myself")

if [[ "$decision" == "YES, let the script do it" ]]; then

	_startServices

elif [ "$decision" == "NO, I'll do it myself" ]; then
    	echo -e "${GREEN}"
		echo "Finalizing setup"
else
	echo -e "${RED}"
	echo ":: Setup Canceled"
	exit 130
fi

