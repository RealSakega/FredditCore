#! /bin/bash

cd "$(dirname "$0")"

bash ./make_minecraft_servers.sh command "say Server restarting in 5 minutes"
bash ./make_minecraft_servers.sh command "discordsrv bcast Automatic server restart in 5 minutes"

sleep 4m

bash ./make_minecraft_servers.sh command "say Server restarting in 1 minute"

sleep 1m

bash ./make_minecraft_servers.sh command "say Server restarting now"
bash ./make_minecraft_servers.sh command "stop"

exit 0
