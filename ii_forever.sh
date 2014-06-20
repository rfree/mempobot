
source "irc.conf"

while true 
do
	echo "starting ii irc connection: " "$@"
	ii "$@"
	echo "irc exited, will restart"
	sleep 5
done


