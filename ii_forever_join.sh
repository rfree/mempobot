#!/bin/bash

source "irc.conf"

sleep 10

while true;
do
	echo "/join #mempo" > "$IRC_BASEDIR/$IRC_HOST/in"
	sleep 1200
	sleep $((RANDOM%100))
done

