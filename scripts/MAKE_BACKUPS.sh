#! /bin/bash

cd "$(dirname "$0")"

cd ../minecraft/servers

for server in $(ls ../minecraft/servers | grep -v shared); do
    echo "Backing up $server"
    cd $server
    make backup
    cd ..
done