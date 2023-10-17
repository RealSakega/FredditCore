#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
    echo "Usage: $0 dir"
    exit 1
fi

cd $1

# TODO