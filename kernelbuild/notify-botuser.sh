#!/bin/bash 

# WARNING: currently this needs to be run from the pwd in which this file is located,
# to mass message.txt (as well as to load the config source)
source ../messaging.conf 

light_red='\e[1;31m' 
NC='\e[0m' # No Color

ADDRESS=$KERNELBUILD_TO_BOTUSER/$FLAG_DIR 
#   mkdir -p $ADDRESS    # botmempo should created it...

# because mkdir -p was not preserving setfacl somehow...
function makedir_maybe {
	dir=$1
	if [[ ! -d "$dir" ]] ; then
		mkdir "$dir"
	fi
}

makedir_maybe "$KERNELBUILD_TO_BOTUSER"
makedir_maybe "$KERNELBUILD_TO_BOTUSER/$FLAG_DIR"

if [[ ! -d "$ADDRESS" ]] ; then
	echo "The directory does not exist ($ADDRESS), exiting"
	sleep 1 # sleep
	exit 1 # <--------------------
fi

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
