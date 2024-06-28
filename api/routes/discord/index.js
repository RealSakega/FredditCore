import { Router } from 'express';

const discord = Router();

const DISCORD_WEBHOOK_URL = process.env.DISCORD_WEBHOOK_URL;

discord.post('/', async (req, res) => {
    try {
        const { message } = req.body;

        if (!message) {
            return res.status(400).json({ message: 'Message is required' });
        }

        if (!DISCORD_WEBHOOK_URL) {
            return res.status(500).json({ message: 'Discord Webhook URL is not set' });
        }

        // send message to discord webhook
        await fetch(DISCORD_WEBHOOK_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ content: message }),
        });

        res.json({ message: 'Message sent to Discord' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

export default discord;