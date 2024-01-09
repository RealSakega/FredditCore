#! /bin/bash
IFS=$' \t\r\n'

cd "$(dirname "$0")"

if [ -f ../.config/.env-minecraft ]
then
  export $(cat ../.config/.env-minecraft | xargs)
fi

# same as BACKUP.sh
post_status () {
  msg=$(echo $1 | sed -r 's/^.{2}//' | sed 's/.$//')
  curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$msg\"}" "$BACKUP_LOGS_CHANNEL_WEBHOOK"
}

# https://unix.stackexchange.com/questions/119126/command-to-display-memory-usage-disk-usage-and-cpu-load
mem=$(free -m | awk 'NR==2{printf "Memory: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
disk=$(df -h | awk '$NF=="/"{printf "Disk: %d/%dGB (%s)\n", $3,$2,$5}')
screens=$(screen -ls | grep Detached | awk '{print "/ " $1 }')

server_status="$(
  $mem, $disk 
  $screens
)"
