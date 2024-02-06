#! /bin/bash

MEM_MIN=$1
MEM_MAX=$2

if [ -z "$MEM_MIN" ] || [ -z "$MEM_MAX" ]; then
	echo "Incorrect memory parameters (MEM_MIN: $MEM_MIN, MEM_MAX: $MEM_MAX)"
	exit 1
fi

while :
do
	java -Xms${MEM_MIN} -Xmx${MEM_MAX} -jar paper.jar nogui --world-container worlds
	echo "Restarting..."
	sleep 1
done

exit 0
