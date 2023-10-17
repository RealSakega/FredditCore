#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 1 ]; then
    echo "Usage: $0 dir"
    exit 1
fi

cd $1
ls -1 | grep -E '^[a-zA-Z0-9_-]+-[0-9]+\.[0-9]+\.[0-9]+\.jar$' | sed -E 's/([a-zA-Z0-9_-]+)-([0-9]+\.[0-9]+\.[0-9]+)\.jar/\1 \2/' | sort -k1,1 -k2,2V | awk '{print $1"-"$2".jar"}' | awk 'NR>1' | xargs rm