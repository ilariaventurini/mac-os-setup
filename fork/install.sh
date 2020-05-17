#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
backup_dir=~/mac-os-setup-backup/fork/fork_$current_date

#-------------------------------------
# Install
#-------------------------------------

echo -e "\n› Check if Fork is installed..."

# Check if Fork is installed
if [ ! -d '/Applications/Fork.app' -a ! -d "$HOME/Applications/Fork.app" ]
then
  echo -e '  Fork is not installed. Installing...'
  brew cask install fork
fi
echo -e "  Fork already installed."
echo -e "  ➜ Ok"

#-------------------------------------
# Settings
#-------------------------------------

echo -e "\n› Read the readme and set things manually."