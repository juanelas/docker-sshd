#!/bin/sh

if [ ! -f /home/.users ]; then
    echo "Initializing empty users' volume"
    touch /home/.users
    chmod 600 /home/.users
else
    echo "Users' volume already initialized. Loading existing users"
    users=$(awk -F ':' '{print $1}' /home/.users)
    for user in $users; do
        adduser -D $user
    done
    chpasswd -e < /home/.users
    chmod 600 /home/.users
fi

# generate host keys if not present
mkdir -p /opt/sshd/etc/ssh
ssh-keygen -A -f /opt/sshd
echo 

# do not detach (-D), log to stderr (-e), passthrough other arguments
# exec /usr/sbin/sshd -D -e $@
echo "Starting SSH server"
/usr/sbin/sshd -D