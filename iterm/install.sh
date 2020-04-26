#!/bin/bash

# Check if iTerm2 is installed
if [! -d '/Applications/iTerm.app' -a ! -d "$HOME/Applications/iTerm.app"]
then
  echo 'iTerm2 is not installed. Installing it...'
  brew install iTerm2
  echo "...done"
fi
echo "iTerm2 already installed."