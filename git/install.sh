#!/bin/bash

# Check if git is installed
command -v git >/dev/null 2>&1 || { 
  echo >&2 "Git is not installed. Installing...";
  brew install git
}
echo "Git already installed."

# Check if Git fork is installed
if [! -d '/Applications/Fork.app' -a ! -d "$HOME/Applications/Fork.app"]
then
  echo 'Fork is not installed. Installing it...'
  brew install fork
  echo "...done"
fi
echo "Fork already installed."
