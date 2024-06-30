#!/bin/bash

source ../.config/.env-database

LUCKPERMS_PREFIX="luckperms_"
LUCKPERMS_TABLES=("groups" "group_permissions" "group_users" "players" "user_permissions" "user_permissions")
COREPROTECT_TABLES=("block" "blockdata" "container" "containerdata" "entity" "entitydata" "explosions" "explosionsdata" "player" "playerdata" "session" "sessiondata" "sign" "signchanges")

mysql << EOF
CREATE DATABASE IF NOT EXISTS Freebuild;
CREATE DATABASE IF NOT EXISTS Survival;

CREATE USER IF NOT EXISTS '$FREEBUILD_COREPROTECT_USER'@'localhost' IDENTIFIED BY '$FREEBUILD_COREPROTECT_PASSWORD';
$(for table in "${COREPROTECT_TABLES[@]}"; do echo "GRANT ALL PRIVILEGES ON Freebuild.$table TO '$FREEBUILD_COREPROTECT_USER'@'localhost';"; done)

CREATE USER IF NOT EXISTS '$FREEBUILD_LUCKPERMS_USER'@'localhost' IDENTIFIED BY '$FREEBUILD_LUCKPERMS_PASSWORD';
$(for table in "${LUCKPERMS_TABLES[@]}"; do echo "GRANT ALL PRIVILEGES ON Freebuild.$LUCKPERMS_PREFIX$table TO '$FREEBUILD_LUCKPERMS_USER'@'localhost';"; done)

CREATE USER IF NOT EXISTS '$SURVIVAL_COREPROTECT_USER'@'localhost' IDENTIFIED BY '$SURVIVAL_COREPROTECT_PASSWORD';
$(for table in "${COREPROTECT_TABLES[@]}"; do echo "GRANT ALL PRIVILEGES ON Survival.$table TO '$SURVIVAL_COREPROTECT_USER'@'localhost';"; done)

CREATE USER IF NOT EXISTS '$SURVIVAL_LUCKPERMS_USER'@'localhost' IDENTIFIED BY '$SURVIVAL_LUCKPERMS_PASSWORD';
$(for table in "${LUCKPERMS_TABLES[@]}"; do echo "GRANT ALL PRIVILEGES ON Survival.$LUCKPERMS_PREFIX$table TO '$SURVIVAL_LUCKPERMS_USER'@'localhost';"; done)

EOF