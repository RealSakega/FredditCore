#! /bin/bash

cd "$(dirname "$0")"

source ../.secrets/webhook_urls.sh

cd ../minecraft/backups/Freebuild
ls -1t | tail -n +7 | xargs rm
cd ../../..

post_status () {
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" $BACKUPS_STAFF_CHANNEL_WEBHOOK
}

post_status "Creating backup of reality FRFR-25565."
zip -r "minecraft/backups/Freebuild/$(date +"%Y-%m-%d-%H-%M").zip" $(cat minecraft/backups/BackupList_Freebuild.txt)
post_status "Backup completed"
