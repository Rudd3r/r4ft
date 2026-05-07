#!/bin/bash

AGENT_UID=${AGENT_UID:-911}
AGENT_GID=${AGENT_GID:-911}

groupmod -o -g "${AGENT_GID}" agent >/tmp/entrypoint.log 2>&1 || cat /tmp/entrypoint.log
usermod -o -u "${AGENT_UID}" agent >/tmp/entrypoint.log 2>&1 || cat /tmp/entrypoint.log
usermod -d "/home/agent" agent >/tmp/entrypoint.log 2>&1 || cat /tmp/entrypoint.log
chown -R agent:agent /home/agent >/tmp/entrypoint.log 2>&1 || cat /tmp/entrypoint.log
export HOME=/home/agent

if [[ "$@" == "" ]]; then
  exec su --preserve-environment -s /bin/bash agent
else
  exec su --preserve-environment -s /bin/bash -c "$@" agent
fi