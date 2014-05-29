#!/bin/bash -e 

# startirc.sh must be executed!!! 
# irc  
pwd
source irc.conf

echo "$@" > "$BASEDIR/$HOST/#mempo/in" & 

# FMS 
./send_nttp_fms.sh "$@" || { echo "FMS failed!" ; exit 2; }




