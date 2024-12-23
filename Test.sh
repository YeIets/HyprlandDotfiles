#!/usr/bin/bash

for item in "${Directories[@]}"; do
	cp -f "${dirsPath}""$item"/* "$configDir""$item"
done