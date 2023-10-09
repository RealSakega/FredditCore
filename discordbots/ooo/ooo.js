const Discord = require("discord.js");
const ooo = new Discord.Client();
const disbut = require("discord-buttons")(ooo);
 
const presence_text = "";   // presence status text

ooo.on('ready', () => {
    console.log(`Logged in as ${ooo.user.username}`);
    ooo.user.setPresence({ status: 'online', game: { name: presence_text }})
});

const { MessageButton } = require('discord-buttons');
const { MessageActionRow } = require('discord-buttons');
 
ooo.on('message', async (msg) => {
    if (msg.content == "refreshOOOButtons") {
			let button_start_fb = new MessageButton()
				.setLabel("Start Freebuild")
				.setStyle(1)
				.setID("start_fb")
				
			let button_start_mod = new MessageButton()
				.setLabel("Start Survival")
				.setStyle(1)
				.setID("start_survival")
				
			let button_start_anon = new MessageButton()
				.setLabel("Start Anonventbot")
				.setStyle(1)
				.setID("start_anon")
				
			let button_backup_fb = new MessageButton()
				.setLabel("Backup Freebuild")
				.setStyle(3)
				.setID("backup_fb");
				
			let row = new MessageActionRow()
				.addComponent(button_start_fb)
				.addComponent(button_start_mod)
				.addComponent(button_start_anon);
				
			let row2 = new MessageActionRow()
				.addComponent(button_backup_fb);
	
			// Confirm that the message has been sent
			msg.channel.send("welcome to con:troll: center", {
				components: [row, row2]
			});
		}
});

ooo.on('clickButton', async (button) => {
        fredditloc = '/home/ayybois/Freddit/'
	switch(button.id){
			case "start_fb":
				execute('sh /home/ayybois/Desktop/START_FREEBUILD.sh');
				await button.think(true); 
				break;
				
			case "start_survival":
				execute('sh /home/ayybois/Desktop/START_SURVIVAL.sh');
				await button.think(true);
				break;
				
			case "start_anon":
				execute('sh /home/ayybois/Desktop/start_anon.sh');
				await button.think(true);
				break;
				
			case "backup_fb":
				await button.think(true);
				break;
		}
});

function execute(string) {
	const { exec } = require('child_process');
	var yourscript = exec(string,
		(error, stdout, stderr) => {
				console.log(stdout);
				console.log(stderr);
				if (error !== null) {
						console.log(`exec error: ${error}`);
				}
		});
}
 
ooo.login(process.env.OOO_BOT_TOKEN);
 
