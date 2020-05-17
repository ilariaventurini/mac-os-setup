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

# Zsh dotfiles
#-------------------
echo -e "  › Zsh dotfiles"

echo -e "    › .aliases.sh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.aliases.sh $backup_dir
echo -e "      › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.aliases.sh $home/.aliases.sh

echo -e "    › .functions.sh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.functions.sh $backup_dir
echo -e "      › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.functions.sh $home/.functions.sh

echo -e "    › .totest.sh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.totest.sh $backup_dir
echo -e "      › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.totest.sh $home/.totest.sh

echo -e "    › .spaceship.sh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.spaceship.sh $backup_dir
echo -e "      › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.spaceship.sh $home/.spaceship.sh

echo -e "    › .tab-title.sh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.tab-title.sh $backup_dir
echo -e "      › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.tab-title.sh $home/.tab-title.sh

echo -e "    › .zshrc"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.zshrc $backup_dir
echo -e "      › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.zshrc $home/.zshrc

# VS Code dotfiles
#-------------------
echo -e "  › VS Code dotfiles"

echo -e "    › .vsce"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.vsce $backup_dir
echo -e "      › create symlink: $mos/vscode → $home"
ln -sf $mos/vscode/.vsce $home/.vsce

echo -e "    › com.microsoft.VSCode.plist"
echo -e "      › move old file: $preferences → $backup_dir"
mv $preferences/com.microsoft.VSCode.plist $backup_dir
echo -e "      › create symlink: $mos/vscode → $preferences"
ln -sf $mos/vscode/com.microsoft.VSCode.plist $preferences/com.microsoft.VSCode.plist

echo -e "    › snippets files"
echo -e "      › move old files: $vscode_snippets → $backup_dir"
mv "$vscode_snippets"/* $backup_dir
echo -e "      › create symlink: $mos/vscode/snippets → $vscode_snippets"
echo -e "        › javascript.code-snippets"
ln -sf $mos/vscode/snippets/javascript.code-snippets "$vscode_snippets"/javascript.code-snippets
echo -e "        › random.code-snippets"
ln -sf $mos/vscode/snippets/random.code-snippets "$vscode_snippets"/random.code-snippets
echo -e "        › react.code-snippets"
ln -sf $mos/vscode/snippets/react.code-snippets "$vscode_snippets"/react.code-snippets
echo -e "        › svg.code-snippets"
ln -sf $mos/vscode/snippets/svg.code-snippets "$vscode_snippets"/svg.code-snippets

echo -e "    › keybindings.json"
echo -e "      › move old file: $vscode → $backup_dir"
mv "$vscode"/keybindings.json $backup_dir
echo -e "      › create symlink: $mos/vscode → $vscode"
ln -sf $mos/vscode/keybindings.json "$vscode"/keybindings.json

echo -e "    › settings.json"
echo -e "      › move old file: $vscode → $backup_dir"
mv "$vscode"/settings.json $backup_dir
echo -e "      › create symlink: $mos/vscode → $vscode"
ln -sf $mos/vscode/settings.json "$vscode"/settings.json

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