#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
preferences=~/Library/Preferences
backup_dir=~/mac-os-setup-backup/vscode/vscode_$current_date
vscode=~/Library/Application\ Support/Code/User
vscode_snippets=~/Library/Application\ Support/Code/User/snippets

#-------------------------------------
# Install
#-------------------------------------

echo -e "\n› Check if Visual Studio Code is installed..."

if [! -d '/Applications/Visual Studio Code.app' -a ! -d "$HOME/Applications/Visual Studio Code.app"]
then
  echo -e '  Visual Studio Code is not installed. Installing...'
  brew cask install visual-studio-code
fi
echo -e "  Visual Studio Code already installed."
echo -e "  ➜ Ok"

echo "\n› Installing extensions listed in ~/mac-os-setup/vscode/extensions.txt..."
xargs -n 1 code --install-extension < ~/mac-os-setup/vscode/extensions.txt

#-------------------------------------
# Save old dotfiles in backup_dir and create symlinks
#-------------------------------------

echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

echo -e "\n› Move old dotfiles to $backup_dir and create symlinks..."

echo -e "  › .vsce"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.vsce $backup_dir
echo -e "    › create symlink: $mos/vscode → $home"
ln -sf $mos/vscode/.vsce $home/.vsce

echo -e "  › com.microsoft.VSCode.plist"
echo -e "    › move old file: $preferences → $backup_dir"
mv $preferences/com.microsoft.VSCode.plist $backup_dir
echo -e "    › create symlink: $mos/vscode → $preferences"
ln -sf $mos/vscode/com.microsoft.VSCode.plist $preferences/com.microsoft.VSCode.plist

echo -e "  › snippets files"
echo -e "    › move old files: $vscode_snippets → $backup_dir"
mv "$vscode_snippets"/* $backup_dir
echo -e "    › create symlink: $mos/vscode/snippets → $vscode_snippets"
echo -e "      › javascript.code-snippets"
ln -sf $mos/vscode/snippets/javascript.code-snippets "$vscode_snippets"/javascript.code-snippets
echo -e "      › random.code-snippets"
ln -sf $mos/vscode/snippets/random.code-snippets "$vscode_snippets"/random.code-snippets
echo -e "      › react.code-snippets"
ln -sf $mos/vscode/snippets/react.code-snippets "$vscode_snippets"/react.code-snippets
echo -e "      › svg.code-snippets"
ln -sf $mos/vscode/snippets/svg.code-snippets "$vscode_snippets"/svg.code-snippets

echo -e "  › keybindings.json"
echo -e "    › move old file: $vscode → $backup_dir"
mv "$vscode"/keybindings.json $backup_dir
echo -e "    › create symlink: $mos/vscode → $vscode"
ln -sf $mos/vscode/keybindings.json "$vscode"/keybindings.json

echo -e "  › settings.json"
echo -e "    › move old file: $vscode → $backup_dir"
mv "$vscode"/settings.json $backup_dir
echo -e "    › create symlink: $mos/vscode → $vscode"
ln -sf $mos/vscode/settings.json "$vscode"/settings.json

#-------------------------------------
# Settings
#-------------------------------------

echo -e "\n› Read the readme and set theme and settings things manually."