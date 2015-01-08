#!/bin/bash	
light_blue='\e[1;34m'
NC='\e[0m'
source ../messaging.conf 

ORDERS=$FROM_BOTUSER/$FLAG_DIR/ORDER* 
while true ; 

o="" 
GIT_VER="" 
GIT_URL="" 


echo "Orders are (on start): "
echo "$ORDERS"
ls -l $ORDERS
echo 

do
for o in $ORDERS
do
    if [[  -r "$o" ]] ; then 
        echo -e "\n $o file..."
    # take action on each file. $f store current file name
        GIT_VER=$(head  $o -n 1) 
        GIT_URL=$(tail  $o -n 1) 
	echo "Got order: VER=$GIT_VER  URL=$GIT_URL"
        echo "Removing order" 
        rm -f $o
        echo -e "\n"
        echo -e "${light_blue}Starting script same-kernel.sh ${NC}"
        
        if [[ ! -z "$GIT_VER" ]]; then 
            bash same-kernel.sh $GIT_VER $GIT_URL 
        fi
    fi				
done  
echo -n "."
rm -f  ACCEPT* ORDER* ERROR* CHECKSUM*
sleep 20
done
