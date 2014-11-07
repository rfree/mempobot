
PROJECT STATUS:

Currently (last update: 2014-11-07),
* then use the scripts to build entire mempo kernel, script like: mempo-tools/kernelbuild/download-and-build-all.sh
** of course first prepare tools to build mempo kernel, following https://wiki.debian.org/SameKernel
** also build and install locally the git check tool: mempo-tools/git-gpg-check/ so that command will work on kernelbuild user
* this tool should be usable to have a bot that watches git and then starts build and reports it on irc/nttp etc
** TODO how ever this tool has some problems and is a bit complicated to set up (how ever it CAN work)
** TODO that tool should also call the main script that builds all flavours (but then report all 2*2 or more files)

For install, usage and more see doc/readme.txt 


