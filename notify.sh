#!/bin/bash -e 

# startirc.sh must be executed!!! 
# irc  
pwd
source irc.conf

echo "$@" > "$IRC_BASEDIR/$IRC_HOST/#mempo/in" & 

# FMS 
./send_nttp_fms.sh "$@" || { echo "FMS failed!" ; exit 2; }




