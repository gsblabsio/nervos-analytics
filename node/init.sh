#!/bin/bash

if [ ! -f "/var/lib/ckb/initialized" ]; then
    /bin/docker-entrypoint.sh init --chain mainnet --force
    touch /var/lib/ckb/initialized
fi
