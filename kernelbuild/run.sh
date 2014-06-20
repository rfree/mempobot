#!/bin/bash	

source ../messaging.conf 

ORDERS=$FROM_BOTUSER/$FLAG_DIR/ORDER* 

for o in $ORDERS
do
    echo "$o file..."
    # take action on each file. $f store current file name
    GIT_VER=$(head  $o -n 1) 
    GIT_URL=$(tail  $o -n 1) 
    echo $GIT_VER 
    echo $GIT_URL
    echo -e "\n"
    echo "Sarting script same-kernel.sh"
    bash same-kernel.sh $GIT_VER $GIT_URL
    #rm $o				
done
