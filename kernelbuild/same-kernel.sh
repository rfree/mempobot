#!/bin/bash
echo "-------------------------------------------"
echo "The Mempo's version"
echo "-------------------------------------------"

source ../messaging.conf

light_red='\e[1;31m'
light_green='\e[1;32m'
light_blue='\e[1;34m'
NC='\e[0m'

DATE=$(date +"%Y-%m-%d-%H-%M-%S")
GIT_VER=$1 
GIT_URL=$2

opt_dryrun=false

if [ "$opt_dryrun" = "true" ]; then
	echo -e "${light_red}This is a dry-run, build will not be actually executed.${NC}"
else
	echo "Will do real run"
fi

pwd_start=$PWD
echo -e "${light_blue}Starting in pwd_start=$pwd_start ${NC}"

function notify_botuser() {
	echo "Calling notification while in PWD=$PWD"
	bash notify-botuser.sh "$@"
}

function clear_build_dirs() { 
	local pwd_tmp="$PWD"
	cd "$pwd_start"
	echo ""
	echo "Moving away the old directory, while in PWD=$PWD (should be in bot directory)"

	echo "Calling clear"
		local pwd2="$PWD"
		cd ~/deterministic-kernel
			bash ./cmd-clear.sh  # remove the heavy data (probably will leave behind logs and all)
		cd "$pwd2"

	echo "Moving away - archiving"
	mv ~/deterministic-kernel deterministic-kernel-$DATE 
	echo "Moving away - done"
	echo ""
	cd "$pwd_start"
}

# TODO Message to $BOTUSER about starting compilation

# clean old builds 
if [[ -d  "~/deterministic-kernel" ]] ; then
    clear_build_dirs
fi

echo -e "${light_green}Doing git clone $GIT_URL ${NC}"
ls
git clone $GIT_URL
echo -e "${light_green}Doing git clone $GIT_URL - DONE ${NC}"
cd deterministic-kernel/
ls
pwd
echo -e "${light_green}Switching version to $GIT_VER ${NC}"
git checkout "$GIT_VER" || {
	echo -e "${light_red}Failed to switch to version $GIT_VER of $GIR_URL ${NC}"
	exit 1
}

echo "Ready to build, sending ACCEPTED message to $BOTUSER"

pwd_1=$PWD
cd $pwd_start
	echo "Ready to build" > $MESSAGE 
	notify_botuser "ACCEPTED"
cd $pwd_1


# TODO whitch no $GIT_VER version

# TODO verify signature
#LANG=C git tag -v `git describe --tags`
pwd_before_build=$PWD

echo "Removing old top-dir, we are in $pwd_before_build now"
unlink ~/deterministic-kernel/
rm -rf ~/deterministic-kernel/ 
unlink ~/deterministic-kernel/
echo "Old top-dir should be now removed"

echo "Linking to top-dir for $pwd_before_build"
set -x

# ln -s "$pwd_before_build" ~/deterministic-kernel 
mv "$pwd_before_build" ~/deterministic-kernel 
cd ~/deterministic-kernel/ # enter the top-directory (symlinked) correct dir
set +x
pwd_build=$(pwd)
echo "We are in $pwd_build now"
ls

echo -e "${light_green}STARTING BUILD in dir $pwd_build for $GIT_URL ver $GIT_VER ${NC}"

if [ "$opt_dryrun" = "true" ]; then
	echo -e "${light_red}NOT ACTUALLY BUILDING (this is just a dryrun) ${NC}"
else
	echo -e "${light_green}RUNNING THE ACTUAL BUILD SCRIPT NOW ${NC}"
	./run.sh || {
		echo -e "${light_red}WARNING: THE BUILD SCRIPT FAILED ${NC}"
	}
fi


cd $pwd_before_build

echo -e "${light_blue}END OF BUILD${NC}"

function print_the_checksums {
	local pwd_tmp=$PWD
	cd ~/deterministic-kernel/kernel-build/linux-mempo/
	if [ "$opt_dryrun" = "true" ]; then
		sha256sum *.sh  # dry run
	else
		sha256sum *.deb # real run
	fi
	cd $pwd_tmp
}

sums=$(print_the_checksums | tr '\n' ' ')

echo "Checksums: $sums" 

echo "Notifying"
# if $sums aren't empty
if [[ ! -z "$sums" ]]; then
	pwd_1=$PWD
	cd $pwd_start
	    echo "$sums" > $MESSAGE
	    notify_botuser "CHECKSUMS"
	cd $pwd_1	
else 
	pwd_1=$PWD
	cd $pwd_start
	    echo "Error! Can't find *.deb file. Build of kernel failed!" > $MESSAGE
	    notify_botuser "BUILDING_ERROR"
	cd $pwd_1	
fi

if [ "$opt_dryrun" = "true" ]; then
	echo -e "${light_red}This is a dry-run, will not release.${NC}"
else
	echo "Now doing a release (copy the resulting deb files to proper place)"
	bash ~/cmd-release.sh 
fi

clear_build_dirs

