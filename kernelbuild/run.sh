#!/bin/bash	
light_blue='\e[1;34m'
NC='\e[0m'
source ../messaging.conf 

ORDERS=$FROM_BOTUSER/$FLAG_DIR/ORDER* 
while true ; 

o="" 
GIT_VER="" 
GIT_URL="" 


do
for o in $ORDERS
do
    if [[  -r "$o" ]] ; then 
        echo -e "\n $o file..."
    # take action on each file. $f store current file name
        GIT_VER=$(head  $o -n 1) 
        GIT_URL=$(tail  $o -n 1) 
        echo $GIT_VER 
        echo $GIT_URL
        echo "Removing order" 
        rm -f $o
        echo -e "\n"
        echo -e "${light_blue}Sarting script same-kernel.sh ${NC}"
        
        if [[ ! -z "$GIT_VER" ]] && [[ ! -z  "$GIT_URL" ]]; then 
            bash same-kernel.sh $GIT_VER $GIT_URL 
        fi
    fi				
done  
echo -n "."
sleep 20
done
