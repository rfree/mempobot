#!/bin/bash

source "irc.conf"

nohup bash ii_forever.sh -f "$HOSTNAME" -n mempobot -i "$IRC_BASEDIR/" -s "$IRC_HOST" -p $IRC_PORT &

nohup bash ii_forever_join.sh &

echo "sleep"
sleep 10

echo "done"
sleep 2
echo "Showing out"
#cat "$IRC_BASEDIR/$IRC_HOST/out"

echo "All done"

