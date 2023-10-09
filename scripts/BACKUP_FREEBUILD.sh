cd minecraft/backups/Freebuild
ls -1t | tail -n +7 | xargs rm
cd minecraft/backups/

source ../.secrets/webhook_urls.sh

HOOK_URL= $BACKUPS_STAFF_CHANNEL_WEBHOOK

message="Creating backup of reality FRFR-25565."
msg_content=\"$message\"
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $HOOK_URL

zip -r "FREEBUILD/$(date +"%Y-%m-%d-%H-%M").zip" $(cat BackupList_Freebuild.txt)

message="Backup completed"
msg_content=\"$message\"
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $HOOK_URL
