#!/bin/bash -e
#usage:
# ... "subject" "message_file.txt"

function die() {
		printf -- '%s\n' "ERROR: $*"
		exit 1
}

function writedata() {
	subject=$1
	msg_file=$2
	groups="mempo.bot,bot"
	groups="$groups,mempo"
	#groups="$groups,linux,security,privacy,boards,sites"

#	echo "subject: $subject" >&2
#	echo "msg_file: $msg_file" >&2
#	echo "groups: $groups" >&2

	if [ ! -r $msg_file ] 
	then
		die "Can not read msg_file [$msg_file]"
	fi

	echo "=====================================================================" 
	printf -- '%s\n' "From: bot_mempo"
	printf -- '%s\n' "Newsgroups: $groups"
	printf -- '%s\n' "Followup-To: $groups"
	printf -- '%s\n' "Subject: $subject"
	printf -- '%s\n' ""
	cat -- $msg_file
	echo "=====================================================================" 
#	printf -- '%s\n' "-- "
#	printf -- '%s\n' "Bot delivers updates about Mempo project"
#	printf -- '%s\n' "#mempo on freenode, oftc, irc2p | mempo.org"
#	printf -- '%s\n' "USK@CHC7Mv5yuWGQFLfh50VugNHhSpOe6OLWJiiW9XGC2Z0,m~cCrcXMEaMNTrohcxshKuYvlVzcqbKG6JdiAA1sC6M,AQACAAE/BotMempo/-1/"
}


cfg_path_generate=$3
echo "Saving ARCHIVE to $cfg_path_generate ($1)"
mkdir -p "$cfg_path_generate"
out_file="$cfg_path_generate/messages.txt"

writedata "$1" "$2" >> $out_file

