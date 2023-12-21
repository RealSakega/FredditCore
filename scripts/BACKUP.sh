#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 source_dir target_dir"
    exit 1
fi

NUMBER_OF_BACKUPS_TO_KEEP=5

SCREEN_SESSION=$(echo ${STY#*.} | cut -d. -f1 | cut -d- -f3)

source_dir=$1
target_dir=$2

backup_list="$source_dir/backuplist.txt"

cd $target_dir
ls -1t | tail -n +$NUMBER_OF_BACKUPS_TO_KEEP | xargs rm
cd "$(dirname "$0")/.."

zipname="$(date +"%Y-%m-%d_%H-%M").zip"

post_status () {
    if [ -v BACKUP_LOGS_CHANNEL_WEBHOOK ]; then
        curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"**[$SCREEN_SESSION]** $1\"}" $BACKUP_LOGS_CHANNEL_WEBHOOK
    else
        echo "$1"
    fi
}

backup_list=$(while read -r line; do echo "$line"; ((num_files++)); done < "$backup_list")
backup_list=$(echo "$backup_list" | tr " " "\n")
backup_output_file="$target_dir/$zipname"

screen -r $SCREEN_SESSION -X stuff "save-off^M"
post_status "Creating backup $zipname"
screen -r minecraft-server-${server_name} -X stuff "discord bcast Reality backup in process. ^M"

num_files=$(echo "$backup_list" | wc -l)

i=0
echo "$backup_list" | while read -r line; do
    post_status "Adding \`$line\` to backup... ($((++i))/$num_files)"
    l="$source_dir/$line"
    if zip -ur "$backup_output_file" "$l"; then
        continue
    else
        excode=$?
        if [ $excode -eq 9 ]; then
            post_status ":warning: Backup interrupted."
            exit 1
        elif [ $excode -eq 12 ]; then
            post_status ":warning: Backup failed: \`$line\` not found"
        else
            post_status ":warning: Failed to add \`$line\` to backup"
        fi
    fi
done

screen -r $SCREEN_SESSION -X stuff "save-on^M"
screen -r $SCREEN_SESSION -X stuff "save-all^M"

post_status "Backup complete."
screen -r minecraft-server-${server_name} -X stuff "discord bcast Reality backup complete.^M"

exit 0
