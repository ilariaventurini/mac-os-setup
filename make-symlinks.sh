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

echo -e "    › items.json"
echo -e "      › move old file: $mtmr → $backup_dir"
mv "$mtmr"/items.json $backup_dir
echo -e "      › create symlink: $mos/mtmr → $mtmr"
ln -sf $mos/mtmr/items.json "$mtmr"/items.json

echo -e "    › close.png"
echo -e "      › move old file: $mtmr → $backup_dir"
mv "$mtmr"/close.png $backup_dir
echo -e "      › create symlink: $mos/mtmr → $mtmr"
ln -sf $mos/mtmr/close.png "$mtmr"/close.png

echo -e "    › spotify-icon.png"
echo -e "      › move old file: $mtmr → $backup_dir"
mv "$mtmr"/spotify-icon.png $backup_dir
echo -e "      › create symlink: $mos/mtmr → $mtmr"
ln -sf $mos/mtmr/spotify-icon.png "$mtmr"/spotify-icon.png

echo -e "    › pause-or-play-open.scpt"
echo -e "      › move old file: $mtmr → $backup_dir"
mv "$mtmr"/pause-or-play-open.scpt $backup_dir
echo -e "      › create symlink: $mos/mtmr → $mtmr"
ln -sf $mos/mtmr/pause-or-play-open.scpt "$mtmr"/pause-or-play-open.scpt

echo -e "    › spotify-now-playing.scpt"
echo -e "      › move old file: $mtmr → $backup_dir"
mv "$mtmr"/spotify-now-playing.scpt $backup_dir
echo -e "      › create symlink: $mos/mtmr → $mtmr"
ln -sf $mos/mtmr/spotify-now-playing.scpt "$mtmr"/spotify-now-playing.scpt

echo -e "    › spotify-play-pause.scpt"
echo -e "      › move old file: $mtmr → $backup_dir"
mv "$mtmr"/spotify-play-pause.scpt $backup_dir
echo -e "      › create symlink: $mos/mtmr → $mtmr"
ln -sf $mos/mtmr/spotify-play-pause.scpt "$mtmr"/spotify-play-pause.scpt