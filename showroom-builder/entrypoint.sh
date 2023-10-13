#!/bin/bash

if [ -z "$GIT_REPO_URL" ]; then
  echo "GIT_REPO_URL is not set. Exiting."
  exit 1
fi

# Setup working directory for cloning and rendering

# WORKDIR=/home/antora/repo
WORKDIR=/showroom/repo
#mkdir -p $WORKDIR

echo
echo "git clone the $GIT_REPO_URL into $WORKDIR"
git clone $GIT_REPO_URL $WORKDIR || cd $WORKDIR && git pull
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
if test -r /showroom/user_data/user_data.yml
then
  echo "NOW editing user_data.yml"
  yq -i '.asciidoc.attributes *= load("/showroom/user_data/user_data.yml")' $WORKDIR/content/antora.yml
fi
echo "user_data in content/antora.yml"
cat $WORKDIR/content/antora.yml
echo

# Run antora command (adjust the playbook file as needed)
echo "Run antora site.yml"
antora --to-dir=/showroom/www/ site.yml

echo "Run httpd"
cd /showroom/www/
python3 -m http.server

# Additional commands or logic can be added here if needed
