#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
backup_dir=~/mac-os-setup-backup/git/git_$current_date

#-------------------------------------
# Install
#-------------------------------------

echo -e "\n› Check if git is installed..."

# Check if git is installed
command -v git >/dev/null 2>&1 || { 
  echo >&2 "  Git is not installed. Installing...";
  brew install git
}
echo -e "  Git already installed."
echo -e "  ➜ Ok"

#-------------------------------------
# Save old dotfiles in backup_dir and create symlinks
#-------------------------------------

echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

echo -e "\n› Move old dotfiles to $backup_dir and create symlinks..."

echo -e "  › .gitconfig"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.gitconfig $backup_dir
echo -e "    › create symlink: $mos/git → $home"
ln -sf $mos/git/.gitconfig $home/.gitconfig

echo -e "  › .gitignore_global"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.gitignore_global $backup_dir
echo -e "    › create symlink: $mos/git → $home"
ln -sf $mos/git/.gitignore_global $home/.gitignore_global