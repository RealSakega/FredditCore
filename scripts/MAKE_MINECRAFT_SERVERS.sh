#! /bin/bash

# This script takes a Make target as an argument, and then
# executes it for all Minecraft servers.
#
# For example, `bash MAKE_MINECRAFT_SERVERS.sh backup` would
# execute `make backup` for all of the Minecraft servers.

if [ $# -lt 1 ]; then
    echo "Usage: $0 make_target"
    exit 1
fi

cd "$(dirname "$0")"
cd ../minecraft/servers

for server in $(ls | grep -v shared); do
    cd $server
    make $1
    cd ..
done
exit 0

