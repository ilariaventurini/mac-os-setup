#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
backup_dir=~/mac-os-setup-backup/spotify/spotify_$current_date
app_supp=~/Library/Application\ Support
spotify=~/Library/Application\ Support/Code/Spotify

#-------------------------------------
# Install
#-------------------------------------

echo -e "\n› Check if Spotify is installed..."

# Check if Spotify is installed
if [! -d '/Applications/Spotify.app' -a ! -d "$HOME/Applications/Spotify.app"]
then
  echo -e '  Spotify is not installed. Installing...'
  brew cask install spotify
fi
echo -e "  Spotify already installed."
echo -e "  ➜ Ok"

#-------------------------------------
# Save old dotfiles in backup_dir and create symlinks
#-------------------------------------

# `prefs` file go inside `Users/ilariaventurini/Library/Application Support/spotify/`.

echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

echo -e "\n› Move old dotfiles to $backup_dir and create symlinks..."

echo -e "  › prefs"
echo -e "    › move old file: $spotify → $backup_dir"
mv $spotify/prefs $backup_dir/prefs
echo -e "    › create symlink: $mos/spotify → $spotify"
ln -sf $mos/spotify/prefs $spotify/prefs