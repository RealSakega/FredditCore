<p align="center">
    <img src='assets/freddit-freebuild.png' width='300'>
</p>

### Important bits
- `minecraft/servers/Freebuild` - The Freebuild of Freddit itself. 
- `scripts/BACKUP_FREEBUILD.sh` - Freebuild backup script, uses `minecraft/backups/BackupList_Freebuild.txt` to know which files to include in the backup.
- `discordbots/anonventbot` - Anonventbot's source code.

Most important components have a start script, which can be executed by running `./start` in their respective folders.
