#!/bin/bash 

light_red='\e[1;31m' 
NC='\e[0m' # No Color

source messaging.conf 

ADDRESS=$KERNELBUILD_TO_BOTUSER/$FLAG_DIR 
MESSAGE_CATEGORY=$1

if [[ ! -r "$MESSAGE" ]] ; then 
    echo -e "${light_red}Can not find message file: $MESSAGE ${NC}"
    exit 1
fi 

mv $MESSAGE $MESSAGE_CATEGORY 
cp $MESSAGE_CATEGORY $ADDRESS 
rm $MESSAGE_CATEGORY 

