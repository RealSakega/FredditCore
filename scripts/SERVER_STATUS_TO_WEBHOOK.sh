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
server_status="$(
  date
  # top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 
  free -m | awk 'NR==2{printf "- Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
  df -h | awk '$NF=="/"{printf "- Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
  echo "Active processes:"
  screen -ls | grep Detached | awk '{print "- " $1 " " $2 " " $3}'
)"

post_status "${server_status@Q}"
