#!/bin/bash

# Record the date to the log
date

# Fetch the latest changes from the remote repository
git fetch origin
git checkout auto
git pull origin auto

# Read the desired Node.js version from .node-version
NODE_VERSION=$(cat .node-version)

# Use the required Node.js version
docker run --rm -v "$(pwd):/app" -w /app node:$NODE_VERSION-alpine npm run docker-refresh:blocklist

# Clean any old docker images older than ~1 year
# Unfortunately the prune script does not support a filter to restict to only node images
# Scripting that can be done but is unneccesary here.
docker image prune --all --force --filter "until=9000h"
