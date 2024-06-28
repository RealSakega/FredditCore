#!/bin/bash

sudo apt update && sudo apt full-upgrade -y

sudo apt install build-essential -y
sudo apt install git -y

sudo apt install screen -y
sudo apt install nodejs -y
sudo apt install openjdk-21-jre-headless -y

# ./etc/
sudo crontab -u $(whoami) etc/crontab
sudo cp etc/motd /etc/
