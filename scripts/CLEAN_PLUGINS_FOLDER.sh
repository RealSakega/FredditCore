#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
    echo "Usage: $0 dir"
    exit 1
fi

cd $1

mkdir -p .temp
mv $(ls *.jar | sort -r | awk -F '-' '!seen[$1]++') .temp
rm *.jar
mv .temp/*.jar .
rm -rf .temp
