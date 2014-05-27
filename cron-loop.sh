while true ;
do
		./cron.sh "mempo/deterministic-kernel" "deterministic-kernel" "mempo:kernel:OFFICIAL" ; sleep 2
		./cron.sh "rfree/deterministic-kernel" "deterministic-kernel" "mempo:kernel:rfree" ; sleep 2


		echo "Sleeping"
		sleep 120
		echo "Wake up"
done
