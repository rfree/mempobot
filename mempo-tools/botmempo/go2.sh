#!/bin/bash

sleep 85
sleep $((RANDOM%50))

cd ~/mempobot
bash ./run.sh &

