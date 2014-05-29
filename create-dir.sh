#!/bin/bash 
 
arg_project_dir=$1  
arg_project_name=$2 
dir_skel="var/PROJ/$arg_project_dir"
git_url="https://github.com/"$arg_project_dir".git" 

echo "Creating directory $dir_skel $dir_skel/info"
mkdir -p  $dir_skel  $dir_skel/info 
cd $dir_skel 
git clone $git_url  
cd $arg_project_name

echo "Saving version: $ver_now"
ver_now=$(git log | head -n 1 | cut -d" " -f2) 
echo "$ver_now" > "../info/lastversion" 


