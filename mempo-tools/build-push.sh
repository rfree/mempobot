#!/bin/bash

target_dir="$HOME/kernelbuild.pub/"
echo "Pushing build results to $target_dir"
set -x
cp -nv $HOME/deterministic-kernel/kernel-build/linux-mempo/*.deb $target_dir || {
	echo "Failed to copy files"
	exit 2
}

echo "Done"

