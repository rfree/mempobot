#!/bin/bash 

echo "This script create empty config files and directory" 
echo "Old config files will be removed!" 
echo "Continue? (y/N)" 
read yn  


if [[ $yn == "y" ]] ; then
	echo "Creating directory var/ bin/" 
	mkdir -p var bin 
	echo "Creating config file project.list" 
	echo "# Example: mempo/deterministic-kernel deterministic-kernel mempo:kernel:OFFICIAL test.sh " > project.list
	echo "Creating config file irc.conf" 
	echo "# basedir host port" > irc.conf 
	 
	
else exit 1 ; fi

echo "All done"
