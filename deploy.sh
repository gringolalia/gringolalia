#!/bin/bash

GIT_URL="git@github.com:gringolalia/gringolalia.github.io.git"
GIT_BRANCH="master"

echo -e "Deploying updates to GitHub..."

push_git () {
  msg="Rebuilding site `date`"
  if [ $# -eq 1 ] ; then 
    msg="$1"
  fi
  
  # Commit changes.
  git commit -m "$msg"

  # Push source and build repos.
  git push origin master
  git subtree push --prefix public ${GIT_URL} ${GIT_BRANCH}
}

# Build the project. 
hugo -t ghostwriter

# Add changes to git.
git add --all
git diff --staged --stat

while true; do
    read -p "Do you wish to push these changes? " yn
    case $yn in
        [Yy]* ) push_git; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
