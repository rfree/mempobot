#!/bin/bash -e

# TODO if /home/kernelbuild.pub OR /home/kernelbuild.priv OR  /home/user1.priv OR /home/user1.pub  not exist?   
# run if(whitch acl.... ) usercomm else exit 

GIT_VER=$1
GIT_REPO=$2
GIT_URL="https://github.com/"$GIT_REPO".git"

source messaging.conf


# preparing order's name   
ORDER_DATE=$(date +"%Y-%m-%d-%H-%M-%S")
ORDER="ORDER-$ORDER_DATE" 

# preparing catalog for order
mkdir -p $KERNELBUILD_TO_BOTUSER/$FLAG_DIR 

# messaging to KERNELBUILD
echo "" > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
echo $GIT_VER > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
echo $GIT_URL > $BOTUSER_TO_KERNELBUILD/$FLAG_DIR/$ORDER 
 
# waiting for reply 



