#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 backup_list target_dir"
    exit 1
fi

source_dir=$1
target_dir=$2

backup_list="$source_dir/backuplist.txt"

NUMBER_OF_BACKUPS_TO_KEEP=5

cd $target_dir
ls -1t | tail -n +$NUMBER_OF_BACKUPS_TO_KEEP | xargs rm
cd "$(dirname "$0")/.."

zipname="$(date +"%Y-%m-%d_%H-%M").zip"

post_status () {
    if [ -v BACKUP_LOGS_CHANNEL_WEBHOOK ]; then
        curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" $BACKUP_LOGS_CHANNEL_WEBHOOK
    else
        echo "$1"
    fi
}

backup_output_file="$target_dir/$zipname"

post_status "Creating backup $backup_output_file"

num_files=0
backup_list=$(while read -r line; do echo "$source_dir/$line"; num_files=$num_files + 1; done < "$backup_list")
backup_list=$(echo "$backup_list" | tr " " "\n")

num_files=$(wc -l < "$backup_list")
i=0
echo "$backup_list" | while read -r line; do
    post_status "Adding \`$line\` to backup... ($((++i))/$num_files)"
    if zip -ur "$backup_output_file" "$line"; then
        continue
    else
        excode=$?
        if [ $excode -eq 9 ]; then
            post_status "Backup interrupted."
            exit 1
        elif [ $excode -eq 12 ]; then
            post_status "Backup failed: \`$line\` not found"
        else
            post_status "Failed to add \`$line\` to backup"
        fi
    fi
done

post_status "Backup complete."

exit 0
