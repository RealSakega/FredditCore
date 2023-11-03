#! /bin/bash

cd "$(dirname "$0")"

if [ ! -f ../.secrets/.env-minecraft ]
then
  export $(cat ../.secrets/.env-minecraft | xargs)
fi