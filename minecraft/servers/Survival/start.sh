#!/bin/bash

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 memory_min memory_max"
    exit 1
fi

MEM_MIN=$1
MEM_MAX=$2

java -Xms${MEM_MIN} -Xmx${MEM_MAX} -jar paper.jar nogui --world-container worlds
exit 0
