#!/usr/bin/env bash

# set variables
HOSTS_FILE="/etc/hosts"

system_language=$(echo $LANG | cut -d'_' -f1)

if [[ $system_language == "tr" ]]; then
    source langs/tr
else
    source langs/en
fi

# is user has permission?
if [ "$(id -u)" -ne 0 ]; then
    echo "$RUN_AS_ROOT"
    exit 1
fi

# read input from user
read -p "$WHICH_SITE " DOMAIN

IP="51.38.70.60"

# check domain name in hosts file.
if grep -q "$DOMAIN" $HOSTS_FILE; then
    sed -i "/$DOMAIN/d" $HOSTS_FILE
    echo "$DOMAIN $BLOCKED"
else
    echo "$IP $DOMAIN" >> $HOSTS_FILE
    echo "$DOMAIN $UNBLOCKED"
fi
