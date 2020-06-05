#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
preferences=~/Library/Preferences
backup_dir=~/mac-os-setup-backup/iterm/iterm_$current_date

#-------------------------------------
# Install
#-------------------------------------

echo -e "\n› Check if iTerm2 is installed..."

if [ ! -d '/Applications/iTerm.app' -a ! -d "$HOME/Applications/iTerm.app" ]
then
  echo -e '  iTerm2 is not installed. Installing...'
  brew cask install iTerm2
fi
echo -e "  iTerm2 already installed."
echo -e "  ➜ Ok"

#-------------------------------------
# Save old dotfiles in backup_dir and create symlinks
#-------------------------------------

echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

echo -e "\n› Move old dotfiles to $backup_dir and create symlinks..."

echo -e "  › .iterm2_shell_integration.zsh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.iterm2_shell_integration.zsh $backup_dir
echo -e "    › create symlink: $mos/iterm → $home"
ln -sf $mos/iterm/.iterm2_shell_integration.zsh $home/.iterm2_shell_integration.zsh

echo -e "  › .iterm.sh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.iterm.sh $backup_dir
echo -e "    › create symlink: $mos/iterm → $home"
ln -sf $mos/iterm/.iterm.sh $home/.iterm.sh

echo -e "  › com.googlecode.iterm2.plist"
echo -e "    › move old file: $preferences → $backup_dir"
mv $preferences/com.googlecode.iterm2.plist $backup_dir
echo -e "    › create symlink: $mos/iterm → $preferences"
ln -sf $mos/iterm/com.googlecode.iterm2.plist $preferences/com.googlecode.iterm2.plist

#-------------------------------------
# Settings
#-------------------------------------

echo -e "\n› Read the readme and set theme and settings things manually."