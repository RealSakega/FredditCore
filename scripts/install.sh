#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt update && apt full-upgrade -y
apt install build-essential -y
apt install git -y
apt install screen -y
apt install nodejs -y
apt install openjdk-21-jre-headless -y

# ./etc/
crontab -u $(whoami) ../etc/crontab
cp ../etc/motd /etc/
