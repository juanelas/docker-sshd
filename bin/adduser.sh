#!/bin/sh
user=${1?"You must specify a username."}
passwd=${2?"You must specify a password."}

adduser -D $user
if [ $? -eq 0 ]; then
    echo "${user}:${passwd}" | chpasswd
    if [ $? -eq 0 ]; then
        echo "${user}:$(cryptpw ${passwd})" >> /home/.users
    fi
fi
