#!/bin/bash -e 

# startirc.sh must be executed!!! 
# irc  

irc_conf_file="irc.conf"
all_conf=$(cat $irc_conf_file | sed '/^$/d' | sed  '/^#/ d')
BASEDIR=$(echo "$all_conf" |  awk '{ print $1 }')
HOST=$(echo "$all_conf" |  awk '{ print $2 }')  


echo "$@" > "$BASEDIR/$HOST/#mempo/in" & 

# FMS 
./send_nttp_fms.sh "$@" || { echo "FMS failed!" ; exit 2; }




