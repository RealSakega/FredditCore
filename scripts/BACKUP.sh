#! /bin/bash

cd "$(dirname "$0")"

NUMBER_OF_BACKUPS_TO_KEEP=5

if [ $# -lt 2 ]; then
    echo "Usage: $0 source_dir target_dir"
    exit 1
fi

SILENT=false
if [ $# -lt 3 ]; then
    SILENT=$3
fi

source_dir=$1
target_dir=$2

SCREEN_SESSION=$(echo ${STY#*.} | cut -d. -f1 | cut -d- -f3)
backup_list="$source_dir/backuplist.txt"

save_off () {
    COMMAND="save-off" make -C "$source_dir" command
}
save_on () {
    COMMAND="save-on" make -C "$source_dir" command
}
post_status () {
    if [ -v DEDI_LOGS_CHANNEL_WEBHOOK ]; then
        curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"**[$SCREEN_SESSION]** $1\"}" $DEDI_LOGS_CHANNEL_WEBHOOK
    else
        echo "$1"
    fi
}

save_off 

cd $target_dir
ls -1t | tail -n +$NUMBER_OF_BACKUPS_TO_KEEP | xargs rm
cd "$(dirname "$0")/.."

zipname="$(date +"%Y-%m-%d_%H-%M").zip"

backup_list=$(while read -r line; do echo "$line"; ((num_files++)); done < "$backup_list")
backup_list=$(echo "$backup_list" | tr " " "\n")
backup_output_file="$target_dir/$zipname"

post_status "Creating backup $zipname"

num_files=$(echo "$backup_list" | wc -l)

fail=false
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
            fail=true
            break
        elif [ $excode -eq 12 ]; then
            post_status ":warning: Backup failed: \`$line\` not found"
            fail=true
            break
        else
            post_status ":warning: Failed to add \`$line\` to backup"
        fi
    fi
done

post_status "Backup complete."
save_on

if [ "$fail" = true ]; then
    exit 1
fi

exit 0
