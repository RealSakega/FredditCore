include ../../../Makefile-help
include ../shared/Makefile
include ../../../.config/.env-minecraft
export

server_name = Modded2k24
server_type = forge

screen_name = minecraft-server-${server_name}

include ../../../.config/.env-minecraft-${server_name}
export

mem_min = ${MEMORY_MIN}
mem_max = ${MEMORY_MAX}
discordsrv_token 	= ${DISCORDSRV_TOKEN}
discordsrv_channel 	= ${DISCORDSRV_CHANNEL}
discordsrv_console 	= ${DISCORDSRV_CONSOLE_CHANNEL}
discordsrv_invite 	= ${DISCORDSRV_INVITE_LINK}

wrong_server_type := @echo "${server_name} is not a ${server_type} server. Skipping."

.PHONY: copy-shared-paper-jar
copy-shared-paper-jar: # Copy the latest paper-*.jar file from servers/shared into the server folder as paper.jar
ifeq (${server_type},paper)
	ls -t ../shared/paper_jars/paper-*.jar | head -n 1 | xargs -I {} cp -v {} ./paper.jar
else
	${wrong_server_type}
	@exit 1
endif

.PHONY: copy-shared-plugins-folder
copy-shared-plugins-folder:
ifeq (${server_type},paper)
	cp -rv ../shared/plugins .
else
	${wrong_server_type}
	@exit 1
endif

.PHONY: fix-discordsrv-config
fix-discordsrv-config: # Replace fields from the DiscordSRV config with values from .config/.env-minecraft
ifeq (${server_type},paper)
	sed -i "s/BotToken: \".*/BotToken: \"${discordsrv_token}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \".*/Channels: {\"global\": \"${discordsrv_channel}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \".*/DiscordConsoleChannelId: \"${discordsrv_console}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \".*@DiscordInviteLink: \"${discordsrv_inite}\"@" ./plugins/DiscordSRV/config.yml
else
	${wrong_server_type}
	@exit 1
endif

.PHONY: sessionlock-clean
sessionlock-clean: # Remove session.lock files from the worlds (in case of failed server shutdown)
	find . -name "session.lock" -delete -not -path "./plugins/*"

.PHONY: prepare
prepare: copy-shared-paper-jar copy-shared-plugins-folder fix-discordsrv-config sessionlock-clean

.PHONY: backup
backup: # Perform a backup of the Minecraft server based on backuplist.txt. Optional parameter: SILENT=true/false
	screen -S minecraft-backup-${server_name} -d -m \
		bash ${FREDDITCORE_DIR}/scripts/backup.sh ${FREDDITCORE_DIR}/minecraft/servers/${server_name} ${FREDDITCORE_DIR}/minecraft/backups/${server_name} ${SILENT}

.PHONY: start
start: # Start the Minecraft server in a screen session.
	screen -S ${screen_name} -d -m \
		bash ./start.sh ${server_name} ${mem_min} ${mem_max} true
		@echo "Starting ${server_name}"

.PHONY: stop
stop: # Stop the Minecraft server's screen session
	screen -X -S ${screen_name} quit

.PHONY: command
command: # Execute a command from outside the Minecraft server, e.g. COMMAND="say hi" make command (requires server to be online)
ifeq ($(COMMAND),)
	@echo "Provide a command (e.g., COMMAND=\"say hi\" make command)"
else
	screen -r ${screen_name} -X stuff \
		"${COMMAND}^M"
endif

.PHONY: console
console: # Open the minecraft server's screen session (requires server to be online)
	screen -d -r ${screen_name}

.PHONY: purge-coreprotect-db
purge-coreprotect-db: # Purge Coreprotect data older than 60 days (requires server to be online)
ifeq (${BEFORE},)
	@echo "missing BEFORE parameter (e.g., 'BEFORE=60d make purge-coreprotect-db' to purge data older than 60 days)"
	@exit 1
endif
ifeq (${server_type},paper)
	screen -r ${screen_name} -X stuff \
		"co purge t:${BEFORE}^M"
else
	${wrong_server_type}
	@exit 1
endif
