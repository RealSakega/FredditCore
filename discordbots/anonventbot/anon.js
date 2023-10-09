const Discord = require("discord.js");
 
const anonventbot = new Discord.Client({ 
    intents: 4665, 
    partials: [
        Discord.Partials.Channel, 
        Discord.Partials.Message
    ] 
});

require('dotenv').config({ path: require('find-config')('.env') })

console.log(process.env)

const vent_channel_id = process.env.VENT_CHANNEL_ID // Main venting channel ID. This is where all messages are sent.
const vent_logs_channel_id = process.env.VENT_LOGS_CHANNEL_ID // Logs channel. Make sure this channel is accessible only by the owner, or by trusted admins.
const color = "#0099ff";    // hex code of embed side colour
const presence_text = "";   // presence status text

var last_person = "";   // log last person to identify a new OP

anonventbot.on('ready', () => {
    console.log(`Logged in as ${anonventbot.user.username}`);
    anonventbot.user.setPresence({ status: 'online', game: { name: presence_text }})
});
 
anonventbot.on('messageCreate', (msg) => {
    console.log(msg)
    if (msg.author.bot || msg.guild !== null) return;
    
    if (msg.content == " " || msg.content.length > 1000 || msg.attachments.size > 0){
        msg.channel.send("Sorry, something's wrong. Please make sure your message has less than 1000 characters and has no files uploaded to it. Sorry for the inconvenience, don't let that get in the way though.");
        return;
    }

    // Check for a new OP
    var new_op = (last_person !== msg.author.id ? " (New OP):" : ":");
    last_person = msg.author.id;
    
    // Generate the embed for vent channel message
    var new_embed = new Discord.EmbedBuilder()
    .setColor(color)
    .addFields(
        { name: "Message" + new_op, value: msg.content, inline: true }
    )
    
    // Send message to venting channel
    anonventbot.channels.fetch(vent_channel_id).then((channel) => { send(new_embed) });

    if (vent_logs_channel_id !== -1) {
        // Send message to log channel
        anonventbot.channels.fetch(vent_logs_channel_id).then((channel) => channel.send("> " + msg.content));
        anonventbot.channels.fetch(vent_logs_channel_id).then((channel) => channel.send(msg.author.tag));
    }
    // Confirm that the message has been sent
    msg.react("☑");
});
 
anonventbot.login(process.env.VENT_BOT_TOKEN);
 
