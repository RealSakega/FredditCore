default: help
.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: minecraft-backups
minecraft-backups: # Backup all Minecraft servers
	bash ./scripts/MAKE_BACKUPS.sh

.PHONY: minecraft-servers
minecraft-servers: # Start all Minecraft servers
	bash ./scripts/START_MINECRAFT_SERVERS.sh

.PHONY: status
status: # Post the current server status to the dedi logs channel on Discord
	bash ./scripts/SERVER_STATUS_TO_WEBHOOK.sh
