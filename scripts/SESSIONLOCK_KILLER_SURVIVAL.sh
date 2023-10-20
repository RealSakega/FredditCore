#! /bin/bash

cd "$(dirname "$0")"
cd ../minecraft/servers/Survival

find . -name "session.lock" -delete
