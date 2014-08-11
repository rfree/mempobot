#!/bin/bash
echo "***************************************************************"
echo "using RFREE version"
url="https://github.com/rfree/deterministic-kernel.git"
echo "***************************************************************"

cd ~
rm -rf deterministic-kernel/
git clone $url
cd deterministic-kernel/

git_version=$(git describe --tags)
LANG=C git tag -v `git describe --tags` || {
	echo "Signature failed."
	exit 105
}

#echo "if signature is correct then press ENTER, else Ctrl-C to abort"
#read _

bash run.sh

echo ""
echo "That was RFREE version"
echo "DO NOT FORGET TO HAVE MEMPO PUBLISH IN OFFICIAL REPO"
echo ""

