#! /bin/bash

cd "$(dirname "$0")"

# list of processes that we want to check up on
screens=(
    "minecraft-server-Freebuild"
    "anonventbot"
)

all_present=true

for screen in "${screens[@]}"; do
    if ! screen -list | grep -q "$screen"; then
        echo "Screen $screen not found"
        all_present=false
    fi
done

if $all_present; then
    echo "All screens found"
    exit 0
else
    echo "Not all screens found"
    exit 1
fi
