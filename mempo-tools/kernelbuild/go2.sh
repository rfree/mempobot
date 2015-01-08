#!/bin/bash

sleep 20
sleep $((RANDOM%35))
cd ~/bot_to_build/mempobot/kernelbuild/
bash ./run.sh

