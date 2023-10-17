#! /bin/bash

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
    echo "Usage: $0 backup_list target_dir"
    exit 1
fi

backup_list=$1
target_dir=$2

NUMBER_OF_BACKUPS_TO_KEEP=5

cd ../minecraft/backups/Freebuild
ls -1t | tail -n +$NUMBER_OF_BACKUPS_TO_KEEP | xargs rm
cd ../../..

zipname=$(date +"%Y-%m-%d-%H-%M").zip

if [ -v BACKUPS_STAFF_CHANNEL_WEBHOOK ]; then
    post_status () {
        curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$1\"}" $BACKUPS_STAFF_CHANNEL_WEBHOOK
    }

    backup_output_file = "${target_dir}/${zipname}"

    echo $backup_output_file

    post_status "Creating reality backup. (-> `${backup_output_file}`)"
    zip -r "${backup_output_file}" $(cat ${backup_list})
    post_status "Backup completed"
else 
    echo "BACKUPS_STAFF_CHANNEL_WEBHOOK is not set"
    zip -r "${target_dir}/${zipname}" $(cat ${backup_list})
fi

exit 0
