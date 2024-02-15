#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 3 ]; then
    echo "Usage: $0 server_name memory_min memory_max"
    exit 1
fi

SERVER_NAME=$1
MEM_MIN=$2
MEM_MAX=$3
auto_restart=false

if [ $# == 4 ]; then
    auto_restart=$4
fi

minecraft() {
    java -Xms${MEM_MIN} -Xmx${MEM_MAX} -jar paper.jar nogui --world-container worlds
}

while :
    minecraft
    $auto_restart
do
    if [ -v DEDI_LOGS_CHANNEL_WEBHOOK ]; then
	curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$SERVER_NAME stopped. Performing automatic restart...\"}" $DEDI_LOGS_CHANNEL_WEBHOOK
    else
        echo "Restarting..."
    fi
    sleep 1
done
exit 0
