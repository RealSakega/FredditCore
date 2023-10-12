#! /bin/bash

cd "$(dirname "$0")"

npm ci
node anon.js
