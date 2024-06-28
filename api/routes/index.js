import { Router } from 'express';

import discord from './discord/index.js'
import minecraft from './minecraft/index.js';

const router = Router();

router.use('/discord', discord);
router.use('/minecraft', minecraft);

export default router;
