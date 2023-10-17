include ../../../.secrets/.env-minecraft
include ../shared/Makefile-backup
export

.PHONY: test copy-shared-configs prepare backup start

server_name = Survival

mem_min = ${SURVIVAL_MEMORY_MIN}
mem_max = ${SURVIVAL_MEMORY_MAX}
discordsrv_token 	= ${DISCORDSRV_SURVIVAL_TOKEN}
discordsrv_channel 	= ${DISCORDSRV_SURVIVAL_CHANNEL}
discordsrv_console 	= ${DISCORDSRV_CONSOLE_CHANNEL}
discordsrv_invite 	= ${DISCORDSRV_INVITE_LINK}

test:
	env

copy-shared-paper-jar:
	ls -t ../shared/paper_jars/paper-*.jar | head -n 1 | xargs -I {} cp -v {} ./paper.jar

copy-shared-configs:
	cp -rv ../shared/configs/plugins .
	sed -i "s/BotToken: \"BOTTOKEN\"/BotToken: \"${discordsrv_token}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \"000000000000000000\"}/Channels: {\"global\": \"${discordsrv_channel}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \"000000000000000000\"/DiscordConsoleChannelId: \"${discordsrv_console}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \"discord.gg/changethisintheconfig.yml\"@DiscordInviteLink: \"${discordsrv_inite}\"@" ./plugins/DiscordSRV/config.yml

prepare: copy-shared-paper-jar copy-shared-configs

backup:
	bash ${FREDDITCORE_DIR}/scripts/BACKUP.sh ${FREDDITCORE_DIR}/minecraft/backups/BackupList_${server_name}.txt ${FREDDITCORE_DIR}/minecraft/backups/${server_name}

start:
	java -Xms${mem_min} -Xmx${mem_max} -jar paper.jar nogui --world-container worlds