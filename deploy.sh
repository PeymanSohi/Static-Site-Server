#!/bin/bash

# Variables
USER=username
HOST=your.server.ip
REMOTE_DIR=/var/www/html/static-site

# rsync command
rsync -avz --delete ./static-site/ $USER@$HOST:$REMOTE_DIR
