#!/bin/bash

if [ -z "$GIT_REPO_URL" ]; then
  echo "GIT_REPO_URL is not set. Exiting."
  exit 1
fi

# Setup working directory for cloning and rendering

# WORKDIR=/home/antora/repo
WORKDIR=/repo
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

# Merge user_data.yml into component's antora.yml
# you'll have to mount the user_data.yaml into /showroom
# OpenShift will do it with a configMap
if [ -r /showroom/user_data.yml ]
then
  yq '.asciidoc.attributes *= load("/showroom/user_data.yml")' $WORKDIR/content/antora.yml
fi

# Run antora command (adjust the playbook file as needed)
antora site.yml
httpd -D FOREGROUND -d /antora/www

# Additional commands or logic can be added here if needed
