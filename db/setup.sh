#!/bin/bash

source ../.config/.env-database

create_and_grant () {
    if [ $# -lt 3 ]; then
        echo "Usage: create_and_grant <server> <user> <password> <prefix> <tables>"
        return 1
    fi

    local server=$1
    local user=$2
    local password=$3

    echo "Creating and granting privileges for $server"
    echo "User: $user"
    echo "Password: $password"
    echo "Prefix: $prefix"
    echo "Tables: ${tables[@]}"

    mysql << EOF
CREATE DATABASE IF NOT EXISTS $server;
CREATE USER IF NOT EXISTS '$user'@'localhost' IDENTIFIED BY '$password';
GRANT ALL PRIVILEGES ON $server.* TO '$user'@'localhost';
FLUSH PRIVILEGES;
EOF 

    echo "Created and granted privileges for $server : $user with exit code $?"
    echo "-----------------------------------"
}

create_and_grant "Freebuild" $FREEBUILD_COREPROTECT_USER $FREEBUILD_COREPROTECT_PASS
create_and_grant "Freebuild" $FREEBUILD_LUCKPERMS_USER $FREEBUILD_LUCKPERMS_PASS

create_and_grand "Survival" $SURVIVAL_COREPROTECT_USER $SURVIVAL_COREPROTECT_PASS
create_and_grant "Survival" $SURVIVAL_LUCKPERMS_USER $SURVIVAL_LUCKPERMS_PASS
