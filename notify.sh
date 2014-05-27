#!/bin/bash -e
./send_nttp_fms.sh "$@" || { echo "FMS failed!" ; exit 2; }

echo "$1" > "./var/link/127.0.0.1/#mempo/in" & 


