include ../shared/Makefile
include ../../../.config/.env-minecraft
export

.PHONY: console copy-shared-paper-jar copy-shared-plugins-folder fix-discordsrv-config prepare backup start full-start save-all save-on save-off stop restart

server_name = Freebuild

mem_min = ${FREEBUILD_MEMORY_MIN}
mem_max = ${FREEBUILD_MEMORY_MAX}
discordsrv_token 	= ${DISCORDSRV_FREEBUILD_TOKEN}
discordsrv_channel 	= ${DISCORDSRV_FREEBUILD_CHANNEL}
discordsrv_console 	= ${DISCORDSRV_FREEBUILD_CONSOLE_CHANNEL}
discordsrv_invite 	= ${DISCORDSRV_INVITE_LINK}

default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

copy-shared-paper-jar: # Copy the latest paper-*.jar file from servers/shared into the server folder as paper.jar
	ls -t ../shared/paper_jars/paper-*.jar | head -n 1 | xargs -I {} cp -v {} ./paper.jar

copy-shared-plugins-folder:
	cp -rv ../shared/plugins .

fix-discordsrv-config: # Replace fields from the DiscordSRV config with values from .config/.env-minecraft
	sed -i "s/BotToken: \".*/BotToken: \"${discordsrv_token}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \".*/Channels: {\"global\": \"${discordsrv_channel}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \".*/DiscordConsoleChannelId: \"${discordsrv_console}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \".*@DiscordInviteLink: \"${discordsrv_inite}\"@" ./plugins/DiscordSRV/config.yml

sessionlock-clean: # Remove session.lock files from the worlds (in case of failed server shutdown)
	find . -name "session.lock" -delete -not -path "./plugins/*"

prepare: copy-shared-paper-jar copy-shared-plugins-folder fix-discordsrv-config sessionlock-clean

backup: # 
	screen -S minecraft-backup-${server_name} -d -m \
		bash ${FREDDITCORE_DIR}/scripts/BACKUP.sh ${FREDDITCORE_DIR}/minecraft/servers/${server_name} ${FREDDITCORE_DIR}/minecraft/backups/${server_name}

start: # Start the Minecraft server
	screen -S minecraft-server-${server_name} -d -m \
		java -Xms${mem_min} -Xmx${mem_max} -jar paper.jar nogui --world-container worlds
		@echo "Starting ${server_name}"

stop: # Stop the Minecraft server's screen session
	screen -X -S minecraft-server-${server_name} quit

full-start: prepare start

console: # Open the minecraft server's screen session (requires server to be online)
	screen -d -r minecraft-server-${server_name}

save-all: # Perform an automatic world save (requires server to be online)
	screen -r minecraft-server-${server_name} -X stuff \
		"save-all^M"

save-off: # Disable automatic world saving (requires server to be online)
	screen -r minecraft-server-${server_name} -X stuff \
		"save-off^M"

save-on: # Enable automatic world saving (requires server to be online)
	screen -r minecraft-server-${server_name} -X stuff \
		"save-on^M"

purge-coreprotect-db: # Purge Coreprotect data older than 60 days (requires server to be online)
	screen -r minecraft-server-${server_name} -X stuff \
		"co purge t:60d^M"