.PHONY: minecraft-backups
minecraft-backups:
	bash ./scripts/MAKE_BACKUPS.sh

.PHONY: minecraft-servers
minecraft-servers:
	bash ./scripts/START_MINECRAFT_SERVERS.sh

.PHONY: status
status:
	bash ./scripts/SERVER_STATUS_TO_WEBHOOK.sh