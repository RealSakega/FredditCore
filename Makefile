include ./Makefile-help
export

.PHONY: start-minecraft-backups
start-minecraft-backups: # Backup all Minecraft servers
	bash ./scripts/MAKE_MINECRAFT_SERVERS.sh backup

.PHONY: start-minecraft-servers
start-minecraft-servers: # Start all Minecraft servers
	bash ./scripts/MAKE_MINECRAFT_SERVERS.sh start

.PHONY: stop-minecraft-servers
stop-minecraft-servers: # Stop all Minecraft servers
	bash ./scripts/MAKE_MINECRAFT_SERVERS.sh stop

.PHONY: status
status: # Post the current server status to the dedi logs channel on Discord
	bash ./scripts/SERVER_STATUS_TO_WEBHOOK.sh
