.PHONY: backups

backup-minecraft-servers:
	for server in $(ls minecraft/servers | grep -v shared); do
		cd minecraft/servers/$server
		make backup
		cd ..
	done