#! /bin/bash

############################################################
# Very rudimentary script to perform a safe server restart #
############################################################

cd "$(dirname "$0")"

minecraft_msg() {
    cd ../minecraft/servers
    for server in $(ls | grep -v shared); do
        cd $server
        make command "say $1"
        cd ..
    done
    cd "$(dirname "$0")"
}

minecraft_msg "Server is restarting in 5 minutes."
sleep 4m
minecraft_msg "Server is restarting in 1 minute."
sleep 1m
minecraft_msg "Server is restarting now."
sleep 5

bash ./MAKE_MINECRAFT_SERVERS.sh stop
sleep 1m
bash ./MAKE_MINECRAFT_SERVERS.sh start
