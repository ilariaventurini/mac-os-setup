#!/bin/bash

#####################################
# Set variables
#####################################

current_date=`(date +%Y-%m-%d_%H%M%S)`

home=~/
mos=~/mac-os-setup
backup_dir=~/dotfiles_backup/$current_date # old dotfiles backup directory
app_supp=~/Library/Application\ Support
preferences=~/Library/Preferences
vscode=~/Library/Application\ Support/Code/User
vscode_snippets=~/Library/Application\ Support/Code/User/snippets
mtmr=~/Library/Application\ Support/MTMR

#####################################
# Save old dotfiles in backup_dir and create symlinks
#####################################

echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

echo -e "\n› Move old dotfiles to $backup_dir and create symlinks..."

# MTMR dotfiles
#-------------------

echo -e "  › MTMR dotfiles"

