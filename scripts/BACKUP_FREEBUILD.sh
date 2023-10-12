cd $MINECRAFT_DIR/backups/Freebuild
ls -1t | tail -n +7 | xargs rm
cd $MINECRAFT_DIR/backups/

source ../.secrets/webhook_urls.sh

HOOK_URL= $BACKUPS_STAFF_CHANNEL_WEBHOOK

post_status () {
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" $HOOK_URL
}

post_status "Creating backup of reality FRFR-25565."
zip -r "Freebuild/$(date +"%Y-%m-%d-%H-%M").zip" $(cat BackupList_Freebuild.txt)
post_status "Backup completed"
