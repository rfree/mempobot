#!/bin/bash

echo
echo "Going to start the Mempo secure kernel build. In case of trouble read all on http://mempo.org (or .i2p for i2p anonymous network) and ask us on IRC (wait for reply!)"
echo 

flavour=$1
git_user=$2

cmd="git-gpg-check"
if [[ ! -x $(which $cmd) ]] ; then { echo "No command ($cmd) is not found/not executable. You need to install this program and add to PATH. See the readme."  ; exit 1 ; } fi

thedir="$HOME/deterministic-kernel"

if [[ -z "$flavour" ]] ; then echo "Specify the flavour to build (as command line argument nr 1 to this script), like desk or deskmax, or use the word 'none' to just download/prepare"; exit 1 ; fi
if [[ -z "$git_user" ]] ; then git_user="mempo" ; fi

echo "Will build kernel:"
echo "  flavour=$flavour"
echo "  git_user=$git_user"

cd ~
rm -rf "$thedir" 
git clone "https://github.com/$git_user/deterministic-kernel.git" || { echo "ERROR: Failed to git clone" ; exit 1 ; }
cd "$thedir" || { echo "ERROR: Can not enter $thedir" ; exit 1 ; } 

gpg_was_ok=nope
git_tag=$( git describe --tags )
echo "This is git tag: $git_tag"
echo "Will verify this tag:"
set -x
( LANG=C git tag -v $git_tag 3>&1 1>&2- 2>&3- ) | git-gpg-check -c && { echo GPG_OK ; gpg_was_ok="yes" ; } || { echo GPG_CHECK_FAILED ; echo "GPG check failed, make sure you have the GPG key and you trust it" ; exit 50 ; }
set +x

if [[ "x$gpg_was_ok" == "xyes" ]] ; then
	echo "GPG verified, ok"
else
	echo "GPG NOT VERIFIED XXXXX (double-checked)"
	exit 51
fi

if [[ $flavour == 'none' ]] ;
then
	ls "$thedir"
	echo "Ok all done, not building anything as requested."
	echo "Files are ready in: $thedir"
else

	echo "Ok starting build script:"
	./run-flavour.sh "$flavour"

	echo "Build process finished, will now publish"
	mkdir -p ~/publish/

# we are in deterministic-kernel/
	cp -v kernel-build/linux-mempo/*deb ~/publish/ && echo "Copied the files" 

fi

echo
echo

