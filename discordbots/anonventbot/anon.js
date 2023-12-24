const Discord = require("discord.js");
 
const anonventbot = new Discord.Client({ 
    intents: [
        Discord.GatewayIntentBits.MessageContent,
        Discord.GatewayIntentBits.DirectMessages
    ],
    partials: [
        Discord.Partials.Channel, 
        Discord.Partials.Message
    ] 
});

const vent_channel_id = process.env.VENT_CHANNEL_ID + '' // Main venting channel ID. This is where all messages are sent.
const vent_logs_channel_id = process.env.VENT_LOGS_CHANNEL_ID + '' // Logs channel. Make sure this channel is accessible only by the owner, or by trusted admins.

let vent_channel, vent_logs_channel

const color = '#0099ff';    // hex code of embed side colour
const presence_text = '';   // presence status text
let last_person = '';       // log last person to identify a new OP

anonventbot.on('ready', async () => {
    anonventbot.user.setPresence({ status: 'online', game: { name: presence_text }})

    vent_channel = await anonventbot.channels.fetch(vent_channel_id)
    vent_logs_channel = await anonventbot.channels.fetch(vent_logs_channel_id)

    console.log(vent_channel)

    console.log(`Logged in as ${anonventbot.user.username}`);
});
 
anonventbot.on('messageCreate', (msg) => {
    if (msg.author.bot || msg.guild !== null) return;
    
    if (msg.content.trim() == '' || msg.content.length > 1000 || msg.attachments.size > 0){
        msg.channel.send("Sorry, something's wrong. Please make sure your message has less than 1000 characters and has no files uploaded to it. Sorry for the inconvenience, don't let that get in the way though.");
        return;
    }

    // Check for a new OP
    const new_op = (last_person !== msg.author.id ? ' (New OP):' : ':');
    last_person = msg.author.id;
    
    // Generate the embed for vent channel message
    const new_embed = new Discord.EmbedBuilder()
    .setColor(color)
    .addFields(
        { name: 'Message' + new_op, value: msg.content, inline: true }
    )

    // Send message to venting channel
    vent_channel.send({ embeds: [new_embed] })

    // Send message to log channel
    if (vent_logs_channel_id !== -1) {
        vent_logs_channel.send(msg.author.tag + ':\n> ' + msg.content)
    }

    // Confirm that the message has been sent
    msg.react('☑');
});
 
console.log(process.env)
anonventbot.login(process.env.VENT_BOT_TOKEN);
 