#!/bin/sh
user=${1?"You must specify a username."}

deluser $user
if [ $? -eq 0 ]; then
    sed -i "/^${user}:/d" /home/.users
    echo "User ${user} deleted"
fi
