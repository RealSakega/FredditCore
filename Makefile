.PHONY: minecraft-backups

minecraft-backups:
	bash ./scripts/MAKE_BACKUPS.sh

minecraft-servers:
	bash ./scripts/START_MINECRAFT_SERVERS.sh