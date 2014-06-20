#!/bin/bash 

light_red='\e[1;31m' 
NC='\e[0m' # No Color

source ../messaging.conf 

mkdir -p $KERNELBUILD_TO_BOTUSER/$FLAG_DIR 

ADDRESS=$KERNELBUILD_TO_BOTUSER/$FLAG_DIR 
MESSAGE_CATEGORY=$1

if [[ ! -r "$MESSAGE" ]] ; then 
    echo -e "${light_red}Can not find message file: $MESSAGE ${NC}"
    exit 1
fi 

DATE=$(date +"%Y-%m-%d-%H-%M-%S")
MESSAGE_NAME="$MESSAGE_CATEGORY-$DATE" 


mv $MESSAGE $MESSAGE_NAME
echo "Sending message: " 
cp $MESSAGE_NAME $ADDRESS/ 
#rm $MESSAGE_NAME
