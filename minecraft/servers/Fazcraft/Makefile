.PHONY: console backup start stop

server_name = Fazcraft

mem_min = 8G
mem_max = 8G

backup:
	screen -S minecraft-backup-${server_name} -d -m \
		bash ${FREDDITCORE_DIR}/scripts/BACKUP.sh ${FREDDITCORE_DIR}/minecraft/servers/${server_name} ${FREDDITCORE_DIR}/minecraft/backups/${server_name}

console:
	screen -d -r minecraft-server-${server_name}

start:
	screen -S minecraft-server-${server_name} -d -m \
		bash ./run.sh
		@echo "Starting ${server_name}"

stop:
	screen -X -S minecraft-server-${server_name} quit
