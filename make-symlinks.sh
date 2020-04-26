#!/bin/bash

#####################################
# Set variables
#####################################
home=~/
mos=~/mac-os-setup
backup_dir=~/dotfiles_backup # old dotfiles backup directory
app_supp=~/Library/Application\ Support
preferences=~/Library/Preferences
vscode=~/Library/Application\ Support/Code/User
vscode_snippets=~/Library/Application\ Support/Code/User/snippets

# echo ${home}
# echo ${mos}
# echo ${backup_dir}
# echo ${app_supp}
# echo ${preferences}
# echo ${vscode}

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

# iTerm2 dotfiles
#-------------------
echo -e "  › iTerm2 dotfiles"

echo -e "    › .iterm2_shell_integration.zsh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.iterm2_shell_integration.zsh $backup_dir
echo -e "      › create symlink: $mos/iterm → $home"
ln -sf $mos/iterm/.iterm2_shell_integration.zsh $home/.iterm2_shell_integration.zsh

echo -e "    › .iterm.sh"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.iterm.sh $backup_dir
echo -e "      › create symlink: $mos/iterm → $home"
ln -sf $mos/iterm/.iterm.sh $home/.iterm.sh

echo -e "    › .zsh_history"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.zsh_history $backup_dir
echo -e "      › create symlink: $mos/iterm → $home"
ln -sf $mos/iterm/.zsh_history $home/.zsh_history

echo -e "    › com.googlecode.iterm2.plist"
echo -e "      › move old file: $preferences → $backup_dir"
mv $preferences/com.googlecode.iterm2.plist $backup_dir
echo -e "      › create symlink: $mos/iterm → $preferences"
ln -sf $mos/iterm/com.googlecode.iterm2.plist $preferences/com.googlecode.iterm2.plist


# Git dotfiles
#-------------------
echo -e "  › Git dotfiles"

echo -e "    › .gitconfig"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.gitconfig $backup_dir
echo -e "      › create symlink: $mos/git → $home"
ln -sf $mos/git/.gitconfig $home/.gitconfig

echo -e "    › .gitignore_global"
echo -e "      › move old file: $home → $backup_dir"
mv $home/.gitignore_global $backup_dir
echo -e "      › create symlink: $mos/git → $home"
ln -sf $mos/git/.gitignore_global $home/.gitignore_global

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

## COME BACK INSTRUCTIONS