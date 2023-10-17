include ../shared/Makefile
include ../../../.secrets/.env-minecraft
export

.PHONY: test copy-shared-configs prepare backup start

server_name = Freebuild

mem_min = ${FREEBUILD_MEMORY_MIN}
mem_max = ${FREEBUILD_MEMORY_MAX}
discordsrv_token 	= ${DISCORDSRV_FREEBUILD_TOKEN}
discordsrv_channel 	= ${DISCORDSRV_FREEBUILD_CHANNEL}
discordsrv_console 	= ${DISCORDSRV_CONSOLE_CHANNEL}
discordsrv_invite 	= ${DISCORDSRV_INVITE_LINK}

test:
	env

copy-shared-paper-jar:
	ls -t ../shared/paper_jars/paper-*.jar | head -n 1 | xargs -I {} cp -v {} ./paper.jar

copy-shared-plugins-folder:
	cp -rv ../shared/configs/plugins .

fix-discordsrv-config:
	sed -i "s/BotToken: \"BOTTOKEN\"/BotToken: \"${discordsrv_token}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \"000000000000000000\"}/Channels: {\"global\": \"${discordsrv_channel}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \"000000000000000000\"/DiscordConsoleChannelId: \"${discordsrv_console}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \"discord.gg/changethisintheconfig.yml\"@DiscordInviteLink: \"${discordsrv_inite}\"@" ./plugins/DiscordSRV/config.yml

prepare: copy-shared-paper-jar copy-shared-plugins-folder fix-discordsrv-config

backup:
	bash ${FREDDITCORE_DIR}/scripts/BACKUP.sh ${FREDDITCORE_DIR}/minecraft/backups/BackupList_${server_name}.txt ${FREDDITCORE_DIR}/minecraft/backups/${server_name}

start:
	java -Xms${mem_min} -Xmx${mem_max} -jar paper.jar nogui --world-container worlds

first-start: prepare start
