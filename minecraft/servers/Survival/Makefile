include ../shared/Makefile
include ../../../.secrets/.env-minecraft
export

.PHONY: test copy-shared-configs prepare backup start full-start test-discordsrv save fullstop stop restart open

server_name = Survival

mem_min = ${SURVIVAL_MEMORY_MIN}
mem_max = ${SURVIVAL_MEMORY_MAX}
discordsrv_token 	= ${DISCORDSRV_SURVIVAL_TOKEN}
discordsrv_channel 	= ${DISCORDSRV_SURVIVAL_CHANNEL}
discordsrv_console 	= ${DISCORDSRV_SURVIVAL_CONSOLE_CHANNEL}
discordsrv_invite 	= ${DISCORDSRV_INVITE_LINK}

test:
	env

copy-shared-paper-jar:
	ls -t ../shared/paper_jars/paper-*.jar | head -n 1 | xargs -I {} cp -v {} ./paper.jar

copy-shared-plugins-folder:
	cp -rv ../shared/plugins .

clean-plugins-folder:

fix-discordsrv-config:
	sed -i "s/BotToken: \".*/BotToken: \"${discordsrv_token}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \".*/Channels: {\"global\": \"${discordsrv_channel}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \".*/DiscordConsoleChannelId: \"${discordsrv_console}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \".*@DiscordInviteLink: \"${discordsrv_inite}\"@" ./plugins/DiscordSRV/config.yml

sessionlock-clean:
	find . -name "session.lock" -delete -not -path "./plugins/*"

prepare: copy-shared-paper-jar copy-shared-plugins-folder clean-plugins-folder fix-discordsrv-config sessionlock-clean

backup:
	screen -S minecraft-backup-${server_name} -d -m bash ${FREDDITCORE_DIR}/scripts/BACKUP.sh ${FREDDITCORE_DIR}/minecraft/backups/BackupList_${server_name}.txt ${FREDDITCORE_DIR}/minecraft/backups/${server_name}

start:
	screen -S minecraft-server-${server_name} -d -m java -Xms${mem_min} -Xmx${mem_max} -jar paper.jar nogui --world-container worlds

full-start: prepare start

open:
	screen -r minecraft-server-${server_name}

test-discordsrv:
	screen -r minecraft-server-${server_name} -X stuff "discord bcast Test message^M"

save:
	screen -r minecraft-server-${server_name} -X stuff "save-all^M"

fullstop:
	screen -r minecraft-server-${server_name} -X stuff "stop^M"
	
restart:
	screen -r minecraft-server-${server_name} -X stuff "restart^M"

stop: save wait fullstop
