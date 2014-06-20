echo "-------------------------------------------"
echo "The Mempo's version"
echo "-------------------------------------------"

source ../messaging.conf

DATE=$(date +"%Y-%m-%d-%H-%M-%S")
GIT_VER=$1 
GIT_URL=$2

function clear() { 
    bash deterministic-kernel/cmd-clear.sh 
    mv deterministic-kernel deterministic-kernel-$DATE 
}

# TODO Message to $BOTUSER about starting compilation


# clean old builds 
if [[ -d  $DIRECTORY ]] ; then
    clear
fi

#git clone $GIT_URL

echo "Ready to build" > $MESSAGE 
bash notify.sh "ACCEPTED-$DATE"


# TODO wchitch no $GIT_VER version

# TODO verify signature
#LANG=C git tag -v `git describe --tags`

#bash deterministic-kernel/run.sh 

#sha256sum deterministic-kernel/kernel-build/linux-mempo/*.sh
#:
sums=$(sha256sum deterministic-kernel/kernel-build/linux-mempo/*.deb) 
echo "Build done: $sums" > $MESSAGE
bash notify.sh "CHECKSUMS-$DATE"



clear
