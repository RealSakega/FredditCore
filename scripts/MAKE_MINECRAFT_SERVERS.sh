#! /bin/bash

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