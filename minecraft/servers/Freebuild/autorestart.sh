#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 memory_min memory_max"
    exit 1
fi

MEM_MIN=$1
MEM_MAX=$2

while :
do
	bash ./start.sh $MEM_MIN $MEM_MAX
	echo "Restarting..."
	sleep 1
done
exit 0
