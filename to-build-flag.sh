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
mkdir -p $BOTUSER_TO_KERNELBUILD/$FLAG_DIR 

# messaging to KERNELBUILD
#echo "" > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
#echo $GIT_VER >> $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
#echo $GIT_URL >> $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
echo "Sending order for kernelbuild"
echo -e "$GIT_VER \n$GIT_URL" > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
# TODO: waiting for reply 
echo "Waiting for reply - sleeping"
sleep 15
#ls $FROM_KERNELBUILD/$FLAG_DIR/ACCEPTED*
#cat $FROM_KERNELBUILD/$FLAG_DIR/ACCEPTED*


stat -t $FROM_KERNELBUILD/$FLAG_DIR/ACCEPTED*  >/dev/null 2>&1 &&  echo -e "${light_green}$KERNELBUILD sent ACCEPTED flag. Kernel is ready to build $config_file ${NC}" || (echo -e "${light_red}Error! Can't read ACCEPTED flag! $config_file ${NC}" &&  exit 1 )

echo "Removing all ACCEPTED flags"
rm -f  $FROM_KERNELBUILD/$FLAG_DIR/ACCEPTED* #&> /dev/null

echo "Waiting for message from kernelbuild"
# if error 
while [ -z "$END_BUILD"  ]; do
    stat -t $FROM_KERNELBUILD/$FLAG_DIR/ERROR*  >/dev/null 2>&1 && ( echo -e "${light_red}$KERNELBUILD sent ERROR flag. Build of kernel failed. ${NC}" && exit 1 ) || echo -n "."
    
    stat -t $FROM_KERNELBUILD/$FLAG_DIR/CHECKSUM*  >/dev/null 2>&1 && ( echo -e "${light_green}$KERNELBUILD sent CHECKSUMS. Kernel is ready. $config_file ${NC}" && END_BUILD="OK" ) || echo -n "."

   sleep 5m
done

# TODO: After build script!

