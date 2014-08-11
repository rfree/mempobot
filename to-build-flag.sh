#!/bin/bash -e 

# TODO if /home/kernelbuild.pub OR /home/kernelbuild.priv OR  /home/user1.priv OR /home/user1.pub  not exist?   
# run if(whitch acl.... ) usercomm else exit 

light_red='\e[1;31m'
light_green='\e[1;32m'
light_blue='\e[1;34m'
NC='\e[0m' 

GIT_VER=$1
GIT_REPO=$2
GIT_URL="https://github.com/"$GIT_REPO".git"

source messaging.conf


# preparing order's name   
ORDER_DATE=$(date +"%Y-%m-%d-%H-%M-%S")
ORDER="ORDER-$ORDER_DATE" 

END_BUILD=""
# preparing catalog for order

# because mkdir -p was not preserving setfacl somehow...
function makedir_maybe {
	dir=$1
	if [[ ! -d "$dir" ]] ; then
		mkdir "$dir"
	fi
}
makedir_maybe $BOTUSER_TO_KERNELBUILD/
makedir_maybe $BOTUSER_TO_KERNELBUILD/$FLAG_DIR 

# messaging to KERNELBUILD
#echo "" > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
#echo $GIT_VER >> $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
#echo $GIT_URL >> $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
echo "Sending order for kernelbuild"
echo -e "$GIT_VER \n$GIT_URL" > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 

echo "Waiting for reply from the build-bot"

while true ; do
    if ls $FROM_KERNELBUILD/$FLAG_DIR/ACCEPTED*  &> /dev/null ; then
        echo -e "${light_green}$KERNELBUILD sent ACCEPTED flag. Kernel is ready to build $config_file ${NC}"
        break
    fi 
    echo -n "."
    # TODO abort+report error if over 100 iterations
    sleep 1
done  
echo "Got reply from the build-bot"


echo "Removing all ACCEPTED flags"
rm -f  $FROM_KERNELBUILD/$FLAG_DIR/ACCEPTED* #&> /dev/null

echo "Waiting for message from kernelbuild"



while true ;  do
    # ERROR 
    if ls $FROM_KERNELBUILD/$FLAG_DIR/ERROR*  &> /dev/null ; then
        echo -e "${light_red}$KERNELBUILD sent ERROR flag. Build of kernel failed. ${NC}" && exit 1
    fi
    
    #CHECKSUMS
    if ls $FROM_KERNELBUILD/$FLAG_DIR/CHECKSUM*  &> /dev/null ; then
        echo -e "${light_green}$KERNELBUILD sent CHECKSUMS. Kernel is ready ${NC}"
        break
    fi

    echo -n "."
   
   sleep 1
   # TODO abort+report error if over 100 iterations
   #sleep 5m
done

# continue here if success

sums=$(cat $FROM_KERNELBUILD/$FLAG_DIR/CHECKSUM*) 
rm -f  $FROM_KERNELBUILD/$FLAG_DIR/CHECKSUM*
./notify.sh "build $GIT_VER $GIT_URL: $sums"

