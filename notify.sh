#!/bin/bash -e
./send_nttp_fms.sh "$@" || { echo "FMS failed!" ; exit 2; }

