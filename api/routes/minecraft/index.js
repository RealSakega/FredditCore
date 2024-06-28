import { Router } from 'express';

const minecraft = Router();

const MINECRAFT_SERVER_IP = 'play.freddit.net';

minecraft.get('/', async (req, res) => {
    try {
        if (!MINECRAFT_SERVER_IP) {
            return res.status(500).json({ message: 'Minecraft Server IP is not set' });
        }

        const response = await fetch(`https://api.mcsrvstat.us/2/${MINECRAFT_SERVER_IP}`);

        if (!response.ok) {
            return res.status(500).json({ message: 'Failed to fetch Minecraft server status' });
        }

        const data = await response.json();

        res.json(data);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal Server Error' });
    }
});

export default minecraft;
