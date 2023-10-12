#!/bin/bash

if [ -z "$GIT_REPO_URL" ]; then
  echo "GIT_REPO_URL is not set. Exiting."
  exit 1
fi

# Setup working directory for cloning and rendering

# WORKDIR=/home/antora/repo
WORKDIR=/antora/repo
#mkdir -p $WORKDIR

git clone $GIT_REPO_URL $WORKDIR
cd $WORKDIR

# Extract the name of the repository to use as the working directory
# REPO_NAME=$(basename $GIT_REPO .git)

# Change working directory to cloned repository
# cd $REPO_NAME
#
# Download file with wget
# wget $URL

# Run antora command (adjust the playbook file as needed)
antora site.yml
httpd -D FOREGROUND -d /antora/repo/www

# Additional commands or logic can be added here if needed
