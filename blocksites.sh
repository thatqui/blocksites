#!/usr/bin/env bash

# set variables
HOSTS_FILE="/etc/hosts"

# is user has permission?
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# read input from user
read -p "Which site you want to block/unblock? " DOMAIN

# check domain name in hosts file.
if grep -q "$DOMAIN" $HOSTS_FILE; then
    sed -i "/$DOMAIN/d" $HOSTS_FILE
    echo "$DOMAIN unblocked! Please restart your machine."
else
    echo "127.0.0.1 $DOMAIN" >> $HOSTS_FILE
    echo "$DOMAIN blocked! Please restart your machine."
fi
