include ./Makefile-help
export

.PHONY: minecraft-backups
minecraft-backups: # Backup all Minecraft servers
	bash ./scripts/MAKE_BACKUPS.sh

.PHONY: minecraft-servers
minecraft-servers: # Start all Minecraft servers
	bash ./scripts/START_MINECRAFT_SERVERS.sh

.PHONY: status
status: # Post the current server status to the dedi logs channel on Discord
	bash ./scripts/SERVER_STATUS_TO_WEBHOOK.sh
