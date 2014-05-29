#!/bin/bash -e
# this will check for new versions and run notifications if needed
# -~- mempo.org -~-

# var/PROJ/mempo/deterministic-kernel/deterministic-kernel/deterministic-kernel = git sources 
# var/PROJ/mempo/deterministic-kernel/deterministic-kernel/info/ = dir with info

# bin/ after update scripts to projects 

light_red='\e[1;31m' 
yellow='\e[1;33m'  
light_blue='\e[1;34m'
NC='\e[0m' # No Color

arg_project_dir=$1 # mempo/deterministic-kernel
arg_project_name=$2 # deterministic-kernel (the subdir with source code, usually the name from git clone)
arg_project_title=$3 # mempo:kernel:OFFICIAL mempo:kernel:rfree
arg_project_afterUpdateScript=$4 

after_update_script=$arg_project_afterUpdateScript

# TODO assert $arg_project_dir does not end in / and is dir

cfg_path_git="var/PROJ/$arg_project_dir/$arg_project_name"
cfg_path_info="var/PROJ/$arg_project_dir/info"
cfg_file_verold="$cfg_path_info/lastversion" 

if [[ ! -d "$cfg_path_git" ]] ; then # does the dir exist with checked out git
	echo -e "${light_red}Can not enter $cfg_path_git ${NC} "
	echo "Press ENTER to autoconfigure or Ctrl-C to abort" 
	read _ 
	read _
	bash create-dir.sh $arg_project_dir	$arg_project_name
	#echo "Create that directory by (mkdir -p var/..) and by checking out there the git source code of the project to be monitored"
	#echo "And then try again. Questions: #mempo on i2p or oftc or freenode (and wait up to 48 hours)"
	#exit 1
fi;

if [[ ! -r "$cfg_file_verold" ]] ; then # read old version
	echo "Can not read the old version variable from $cfg_file_verold"
	echo "You should write the current version (the version from which to start monitoring) as the sha string of full git version, as a text file, "
	echo "in one line of text, to file $cfg_file_verold"
	echo "And then try again. Questions: #mempo on i2p or oftc or freenode (and wait up to 48 hours)"
	exit 1
fi

echo "Updating git sources from network in $cfg_path_git"
PWD_=$PWD
	cd $cfg_path_git
	git pull
	git fetch --tags
	ver_now=$(git log | head -n 1 | cut -d" " -f2)
cd $PWD_

sep1a="----v----v----v----"
sep1b="----^----^----^----"

echo "Version now: $ver_now (from git)"

mkdir -p "$cfg_path_info"

ver_old=$(cat "$cfg_file_verold")
echo "ver_old=$ver_old (loaded from $cfg_file_verold)"

function output_log_between_versions() {
	PWD_=$PWD
	cd $cfg_path_git
	echo "Log between $1 .. $2 is:"
	echo "$sep1a git log $sep1a"
	git log "$1".."$2"
	echo "$sep1b git log $sep1b"
	cd $PWD_
}

function output_describe_at() {
	PWD_=$PWD
	cd $cfg_path_git
	git remote -v | head -n 1
	git describe $1
	git describe --long $1
	git tag -v `git describe $1` 2>&1 || :
	cd $PWD_
}

function output_repo_url_raw() {
	PWD_=$PWD
	cd $cfg_path_git
	git remote -v | egrep "^origin" | head -n 1 | sed -e 's/.*\(http[a-zA-Z.:/\+-]*\).*/\1/g'
	# there is probably much easier way and this is really silly...
	cd $PWD_
}

function output_repo_url() {
	name=$(output_repo_url_raw)
	echo "$name" | sed -e 's/http[s]*:\/\///g'
} 

function after_update() { 
	if [[ ! -x $after_update_script ]] ; then 
		echo -e "${yellow}Can not run $arg_project_afterUpdateScript ${NC}"
	else 
		echo -e "${light_blue}Starting $after_update_script ${NC}"
		bash $after_update_script 
	fi

}

# New verion!! 
if [[ "$ver_old" != "$ver_now" ]] 
then

	path_now="$cfg_path_info/now.$ver_old.$ver_now"
	mkdir -p "$path_now"

	echo "Version changed $ver_old != $ver_now"
	echo "Working on reporting event $path_now"
	echo "Working on reporting event $path_now" > "$path_now/log.txt"

	git_name=$( output_repo_url )
	echo "git_name=$git_name"

	echo "" > "$path_now/log.txt"
	echo "Reporting update in GIT repository $git_name" >> "$path_now/log.txt"
	echo "" >> "$path_now/log.txt"
	output_describe_at $ver_now >> "$path_now/log.txt"
	output_log_between_versions $ver_old $ver_now >> "$path_now/log.txt"

	echo "Message:"
	cat "$path_now/log.txt"

	title="[git] $arg_project_title ${ver_now:0:16} $git_name"

	allok=1
	./notify.sh "$title" "$path_now/log.txt" || {
		echo "Notify failed!"
		allok=0
	}
	after_update
	rm -rf "$path_now"

	if [[ $allok != 1 ]] ; then
		echo "error"
		exit 1
	fi


	echo "Saving current version"
	echo "$ver_now" > "$cfg_path_info/lastversion"
	echo "Now last version is:"
	cat "$cfg_path_info/lastversion"
	
	
	

# old version
else
	echo "Same versions, nothing to do"
fi

