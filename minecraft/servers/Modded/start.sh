#!/bin/bash

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 memory_min memory_max"
    exit 1
fi

MEM_MIN=$1
MEM_MAX=$2

## Add server start here
echo "Server not implemented yet!"
sleep 100

exit 0
