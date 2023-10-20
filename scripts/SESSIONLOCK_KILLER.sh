#! /bin/bash

cd "$(dirname "$0")"
cd ../minecraft/servers/Freebuild

find . -name "session.lock" -delete -not -path "./plugins/*"
