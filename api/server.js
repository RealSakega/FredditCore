import express, { json } from "express"
import { default as router } from "./routes/index.js";

import { logger } from "./logger.js"

const app = express()
app.use(json())

const PORT = process.env.PORT || 3000
const API_KEY = process.env.API_KEY

app.use((req, res, next) => {
    if (!req.headers['x-api-key']) {
        logger.error('Unauthorized access, no API key provided')
        res.status(401).json({ message: 'Unauthorized' })
    } else if (req.headers['x-api-key'] === API_KEY) {
        next()
    } else {
        logger.error('Unauthorized access, invalid API key provided')
        res.status(401).json({ message: 'Unauthorized' })
    }
})
    
app.use('/api/1/', router)

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`)
})
