include ../../../.secrets/.env-discordsrv
export

.PHONY: test copy-shared-configs start

test:
	env

copy-shared-configs:
	cp -rv ../shared/configs/plugins .
	sed -i "s/BotToken: \"BOTTOKEN\"/BotToken: \"${FREEBUILD_TOKEN}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s/Channels: {\"global\": \"000000000000000000\"}/Channels: {\"global\": \"${FREEBUILD_CHANNEL}\"}/" ./plugins/DiscordSRV/config.yml
	sed -i "s/DiscordConsoleChannelId: \"000000000000000000\"/DiscordConsoleChannelId: \"${CONSOLE_CHANNEL}\"/" ./plugins/DiscordSRV/config.yml
	sed -i "s@DiscordInviteLink: \"discord.gg@changethisintheconfig.yml\"@DiscordInviteLink: \"${DISCORD_INVITE}\"@" ./plugins/DiscordSRV/config.yml

start:
	bash ./start