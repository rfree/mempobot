#!/bin/bash

BASEDIR="./var/link"
HOST="127.0.0.1"
nohup ii -f "$HOSTNAME" -n mempobot -i "$BASEDIR/" -s "$HOST" -p 6668 &

echo "sleep"
sleep 15
echo "joining"
echo "/JOIN #mempo" > "$BASEDIR/$HOST/in"

echo "done"
sleep 2
echo "Showing out"
cat "$BASEDIR/$HOST/out"

echo "All done"

