#!/bin/bash

freespace="`df -h --output=avail /dev/sda1 | tail -n1`"
percentage="`df /dev/sda1 | awk '{ print $5 }' | tail -n 1`"

TITLE="Disk Usage - $HOSTNAME"
MESSAGE="Disk usage ${percentage//%} procent, there is$freespace left"

APP_TOKEN="<PUSHOVER APP TOKEN>"
USER_TOKEN="<PUSHOVER USER TOKEN>"

if [ ${percentage//%} -ge 95 ]
then
        priority=1
else
        priority=0
fi

if [ ${percentage//%} -ge 85 ]
then
        wget https://api.pushover.net/1/messages.json --post-data="token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE&priority=$priority" -qO- > /dev/null 2>&1 &
fi

if  [[ $1 = "-t" ]]; then
        echo "Testing mode"

        wget https://api.pushover.net/1/messages.json --post-data="token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE&priority=0" -qO- > /dev/null 2>&1 &
fi