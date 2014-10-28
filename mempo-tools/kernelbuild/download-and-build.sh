#!/bin/bash

flavour=$1
git_user=$2

if [[ -z "$flavour" ]] ; then echo "Specify the flavour to build, like desk or deskmax etc"; fi
if [[ -z "$git_user" ]] ; then git_user="mempo" ; fi

echo "Will build kernel:"
echo "  flavour=$flavour"
echo "  git_user=$git_user"

cd ~
rm -rf deterministic-kernel/
git clone https://github.com/mempo/deterministic-kernel.git
cd deterministic-kernel/

gpg_was_ok=nope
git_tag=$( git describe --tags )
echo "This is git tag: $git_tag"
echo "Will verify this tag:"
( LANG=C git tag -v $git_tag 3>&1 1>&2- 2>&3- ) | git-gpg-check -c && { echo GPG_OK ; gpg_was_ok="yes" ; } || { echo GPG_CHECK_FAILED ; echo "GPG check failed, make sure you have the GPG key and you trust it" ; exit 50 ; }

if [[ "x$gpg_was_ok" == "xyes" ]] ; then
	echo "GPG verified, ok"
else
	echo "GPG NOT VERIFIED XXXXX (double-checked)"
	exit 51
fi

echo "Ok starting build script:"
./run-flavour.sh "$flavour"

echo "Build process finished, will now publish"
mkdir -p ~/publish/

cp -v deterministic-kernel/kernel-build/linux-mempo/*deb ~/publish/ && echo "Copied the files" 

echo
echo

