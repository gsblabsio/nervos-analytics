#!/bin/bash

echo "REACT_APP_API_URL=$EXPLORER_BACKEND_URL" >> .env.develop
yarn start