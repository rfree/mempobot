#!/bin/bash -e

cfg_project="deterministic-kernel"
cfg_path_git="var/$cfg_project/$cfg_project"
cfg_path_info="var/$cfg_project/info"

PWD_=$PWD
	cd $cfg_path_git
	git pull
	git fetch --tags
	ver_now=$(git log | head -n 1 | cut -d" " -f2)
cd $PWD_

sep1a="----v----v----v----"
sep1b="----^----^----^----"

echo "Version now: $ver_now"

mkdir -p "$cfg_path_info"
file $cfg_path_info

ver_old=$(cat $cfg_path_info/lastversion)
echo "ver_old=$var_old"


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

	title="[git] $git_name ${ver_now:0:10}"

	allok=1
	./notify.sh "$title" "$path_now/log.txt" || {
		echo "Notify failed!"
		allok=0
	}

	rm -rf "$path_now"

	if [[ $allok != 1 ]] ; then
		echo "error"
		exit 1
	fi


	echo "$ver_now" > "$cfg_path_info/lastversion"
	echo "Now last version is:"
	cat "$cfg_path_info/lastversion"

fi

