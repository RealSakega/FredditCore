include ./Makefile-help
export

.PHONY: start-minecraft-backups
start-minecraft-backups: # Backup all Minecraft servers
	bash ./scripts/make_minecraft_servers.sh backup

.PHONY: start-minecraft-servers
start-minecraft-servers: # Start all Minecraft servers
	bash ./scripts/make_minecraft_servers.sh start

.PHONY: stop-minecraft-servers
stop-minecraft-servers: # Stop all Minecraft servers
	bash ./scripts/make_minecraft_servers.sh stop

.PHONY: status
status: # Post the current server status to the dedi logs channel on Discord
	bash ./scripts/server_status_to_webhook.sh

.PHONY: update-crontab
update-crontab: # Update the crontab
	crontab -u $$(whoami) etc/crontab
