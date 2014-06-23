#!/bin/bash

# colours
light_red='\e[1;31m' 
light_green='\e[1;32m' 
light_blue='\e[1;34m'
NC='\e[0m' # No Color

source options.conf

# Exaple of file projects.list
# mempo/deterministic-kernel deterministic-kernel mempo:kernel:OFFICIAL test.sh 
config_file="projects.list" 
if [[ ! -r "$config_file" ]] ; then 
	echo -e "${light_red}Can not find config file: $config_file ${NC}"
	exit 1
fi;

echo -e "${light_blue}Starting irc bot ${NC}"
./startirc.sh

while true ;
do
	source options.conf # <-- reload the options config

	# Reading data from config file (reload each time too)
	while read line 
	do 
		arg_project_dir=$(echo "$line" |  awk '{ print $1 }')  # mempo/deterministic-kernel 
		arg_project_name=$(echo "$line" |  awk '{ print $2 }') # deterministic-kernel (the subdir with source code, usually the name from git clone) 
		arg_project_title=$(echo "$line" |  awk '{ print $3 }') # mempo:kernel:OFFICIAL mempo:kernel:rfree
		arg_project_afterUpdateScript=$(echo "$line" |  awk '{ print $4 }') # this script will run after every update
		
		echo -e "${light_green}Starting cron for $line ${NC} "
		
		#./cron.sh $arg_project_dir $arg_project_name $arg_project_title $arg_project_afterUpdateScript ; sleep 2
		bash cron.sh $arg_project_dir $arg_project_name $arg_project_title $arg_project_afterUpdateScript ; sleep 2
	done < $config_file		

	echo "Sleeping"
	sleep $OPT_GIT_SLEEP_TIME
	sleep 1
	echo "Wake up"
done
