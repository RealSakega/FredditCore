Miscellaneous tid-bits that are easily forgotten...

# Plugins
## Multiverse-Core
### keepSpawnInMemory
- When creating/importing a new world, the spawn of that world is kept in memory by default, i.e., the spawn chunks will be loaded at all times. Depending on the amount of worlds on the server, this severely impacts performance. To mitigate this, execute `/mv modify set keepSpawnInMemory false <World name>` after creating/importing the world.