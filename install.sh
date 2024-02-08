#!/bin/bash

sudo apt update && sudo apt full-upgrade -y

sudo apt install build-essential -y
sudo apt install git -y

sudo apt install screen -y
sudo apt install nodejs -y
sudo apt install openjdk-17-jre-headless -y

# Currently unused?
sudo mkdir -p /opt/minecraft/tools/mcrcon
sudo git clone https://github.com/Tiiffi/mcrcon /opt/minecraft/tools/mcrcon

# ./etc/
sudo crontab -u $(whoami) etc/crontab
sudo cp etc/motd /etc/
