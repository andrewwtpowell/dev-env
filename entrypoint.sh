#!/bin/sh

# git config
if [ ! -z "$GIT_USER_NAME" ] && [ ! -z "GIT_USER_EMAIL" ]; then
    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"
fi

# Configure 'me' user
USER_ID=${HOST_USER_ID:-9001}
GROUP_ID=${HOST_GROUP_ID:-9001}

# Change 'me' uid and gid to host users' uid and gid
if [ ! -z "$USER_ID" ] && [ "$(id -u me)" != "$USER_ID" ]; then
    groupadd --non-unique -g "$GROUP_ID" group
    usermod --non-unique -uid "$USER_ID" --gid "$GROUP_ID" me
fi

chown -R me: /home/me

exec /sbin/su-exec me tmux -u -2 "$@"
