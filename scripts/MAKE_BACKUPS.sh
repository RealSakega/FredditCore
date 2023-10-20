#! /bin/bash

cd "$(dirname "$0")"

cd ../servers/minecraft

for server in $(ls | grep -v shared); do
    cd $server
    make backup
    cd ..
done