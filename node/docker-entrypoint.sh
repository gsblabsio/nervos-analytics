#!/bin/bash

# Wait for initialization to finish
until [ -f /var/lib/ckb/initialized ]
do
     sleep 5
done

/bin/docker-entrypoint.sh run
