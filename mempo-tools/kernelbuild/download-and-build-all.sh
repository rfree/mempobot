#!/bin/bash

echo
echo "Going to start the Mempo secure kernel build. In case of trouble read all on http://mempo.org (or .i2p for i2p anonymous network) and ask us on IRC (wait for reply!)"
echo "=== GOING to build ALL FLAVOURS ==="
echo 

git_user=$1

cmd="git-gpg-check"
if [[ ! -x $(which $cmd) ]] ; then { echo "No command ($cmd) is not found/not executable. You need to install this program and add to PATH. See the readme."  ; exit 1 ; } fi
if [[ -z "$git_user" ]] ; then echo "Specify the flavour to build (as command line argument nr 1 to this script), like mempo or rfree (for github.com/rfree/)"; exit 1 ; fi

echo "Building for user:"
echo "git_user=$git_user"
echo 

./download-and-build.sh "deb7/maxserv" "$git_user"
./download-and-build.sh "deb7/zero" "$git_user"
./download-and-build.sh "deb7/zero" "$git_user"
./download-and-build.sh "deb7/deskmax" "$git_user"
./download-and-build.sh "deb7/desk" "$git_user"
./download-and-build.sh "deb7/serv" "$git_user"


