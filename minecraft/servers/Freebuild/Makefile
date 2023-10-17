include ../../../.secrets/.env-freddit-dedi
export

.PHONY: test copy-shared-configs prepare start

server_name = Freebuild

mem_min = ${FREEBUILD_MEMORY_MIN}
mem_max = ${FREEBUILD_MEMORY_MAX}

test:
	echo "token: ${DISCORDSRV_FREEBUILD_TOKEN}, channel: ${DISCORDSRV_FREEBUILD_CHANNEL}, console: ${DISCORDSRV_CONSOLE_CHANNEL}, invite: ${DISCORDSRV_INVITE_LINK}"

copy-shared-paper-jar:
	ls -t ../paper-*.jar | head -n 1 | xargs -I {} cp -v {} ./paper.jar

copy-shared-configs:
	cp -rv ../shared/configs/plugins .
	sed -i "s/BotToken: \"BOTTOKEN\"/BotToken: \"${DISCORDSRV_FREEBUILD_TOKEN}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \"000000000000000000\"}/Channels: {\"global\": \"${DISCORDSRV_FREEBUILD_CHANNEL}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \"000000000000000000\"/DiscordConsoleChannelId: \"${DISCORDSRV_CONSOLE_CHANNEL}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \"discord.gg/changethisintheconfig.yml\"@DiscordInviteLink: \"${DISCORDSRV_INVITE_LINK}\"@" ./plugins/DiscordSRV/config.yml

prepare:
	copy-shared-paper-jar
	copy-shared-configs

start:
	java -Xms${mem_min} -Xmx${mem_max} -jar paper.jar nogui --world-container worlds