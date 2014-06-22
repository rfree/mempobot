#!/bin/bash -e 

arg_title=$1
arg_msgfile=$2

# startirc.sh must be executed first

# irc  
pwd
source irc.conf

echo "$arg_title" > "$IRC_BASEDIR/$IRC_HOST/#mempo/in" & 

# FMS 
./send_nttp_fms.sh "$arg_title" "$arg_msgfile" || { echo "NTTP FMS failed!" ; exit 2; }

