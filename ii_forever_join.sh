
source "irc.conf"

sleep 10

while true;
do
	echo "/join #mempo" > "$IRC_BASEDIR/$IRC_HOST/in"
	sleep 60
done
