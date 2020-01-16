#!/bin/sh

# . ./.cyphernodeconf/installer/config.sh

export DOCKER_MODE
export NETWORK
export LIGHTNING_DATAPATH
export APP_SCRIPT_PATH
export GATEKEEPER_DATAPATH
export FEATURE_TOR

if [ "${FEATURE_TOR}" = "true" ]; then
  export TOR_PARAMS=" --proxy socks5h://tor:9050 --rate-provider wasabi "
fi

if [ "$DOCKER_MODE" = "swarm" ]; then
  docker stack deploy -c $APP_SCRIPT_PATH/docker-compose.yaml $APP_ID
elif [ "$DOCKER_MODE" = "compose" ]; then
  docker-compose -f $APP_SCRIPT_PATH/docker-compose.yaml up -d --remove-orphans
fi
