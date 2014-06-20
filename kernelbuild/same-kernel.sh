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

function clear_build_dirs() { 
    bash deterministic-kernel/cmd-clear.sh  # remove the heavy data (probably will leave behind logs and all)
    mv deterministic-kernel deterministic-kernel-$DATE 
}

# TODO Message to $BOTUSER about starting compilation


# clean old builds 
if [[ -d  "deterministic-kernel" ]] ; then
    clear
fi

git clone $GIT_URL

echo "Ready to build, sending ACCEPTED message to $BOTUSER"
echo "Ready to build" > $MESSAGE 
bash notify-botuser.sh "ACCEPTED"


# TODO whitch no $GIT_VER version

# TODO verify signature
#LANG=C git tag -v `git describe --tags`
_PWD=$(pwd)
cd deterministic-kernel/

echo -e "${light_green}STARTING BUILD${NC}"

# /usr/bin/yes | ./run.sh  # XXX dryrun

cd $_PWD

echo -e "${light_blue}END OF BUILD${NC}"

# TODO use test files or the real deb files?
sums=$(sha256sum deterministic-kernel/kernel-build/linux-mempo/*.deb) 
sums=$(sha256sum deterministic-kernel/*.sh)  # XXX dryrun

echo "Checksums: $sums" 
echo "Notifying"
# if $sums aren't empty
if [[ ! -z "$sums" ]]; then
    echo "$sums" > $MESSAGE
    bash notify-botuser.sh "CHECKSUMS"
else 
    echo "Error! Can't find *.deb file. Build of kernel failed!" > $MESSAGE
    bash notify-botuser.sh "BUILDING_ERROR"
fi
clear_build_dirs
