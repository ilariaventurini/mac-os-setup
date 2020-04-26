#!/bin/bash

# Set variables
home=~/
mos=~/mac-os-setup
backup_dir=~/dotfiles_backup # old dotfiles backup directory
app_supp=~/Library/Application\ Support
preferences=~/Library/Preferences
vscode=~/Library/Application\ Support/Code/User
vscode_snippets=~/Library/Application\ Support/Code/User/snippets

echo ${home}
echo ${mos}
echo ${backup_dir}
echo ${app_supp}
echo ${preferences}
echo ${vscode}

# Create backup_dir in homedir
echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

# Move any existing dotfiles to backup_dir directory
echo -e "\n› Move old dotfiles to $backup_dir..."

echo -e "  › Zsh files"
echo -e "    › .aliases.sh: $home → $backup_dir"
# mv $home/.aliases.sh $backup_dir
echo -e "    › .functions.sh: $home → $backup_dir"
# mv $home/.functions.sh $backup_dir
echo -e "    › .spaceship.sh: $home → $backup_dir"
# mv $home/.spaceship.sh $backup_dir
echo -e "    › .tab-title.sh: $home → $backup_dir"
# mv $home/.tab-title.sh $backup_dir
echo -e "    › .zshrc.sh: $home → $backup_dir"
# mv $home/.zshrc.sh $backup_dir

echo -e "  › iTerm2 files"
echo -e "    › .iterm2_shell_integration.zsh: $home → $backup_dir"
# mv $home/.iterm2_shell_integration.zsh $backup_dir
echo -e "    › com.googlecode.iterm2.plist: $preferences → $backup_dir"
# mv $preferences/com.googlecode.iterm2.plist $backup_dir


echo -e "  › Git files"
echo -e "    › .gitconfig: $home → $backup_dir"
# mv $home/.gitconfig $backup_dir
echo -e "    › .gitignore_global: $home → $backup_dir"
# mv $home/.gitignore_global $backup_dir

echo -e "  › VS Code files"
echo -e "    › .vsce.sh: $home → $backup_dir"
# mv $home/.vsce.sh $backup_dir
echo -e "    › com.microsoft.VSCode.plist: $preferences → $backup_dir"
# mv $preferences/com.microsoft.VSCode.plist $backup_dir
echo -e "    › javascript.code-snippets: $vscode_snippets → $backup_dir"
# mv $vscode_snippets/javascript.code-snippets $backup_dir
echo -e "    › random.code-snippets: $vscode_snippets → $backup_dir"
# mv $vscode_snippets/random.code-snippets $backup_dir
echo -e "    › react.code-snippets: $vscode_snippets → $backup_dir"
# mv $vscode_snippets/react.code-snippets $backup_dir
echo -e "    › svg.code-snippets: $vscode_snippets → $backup_dir"
# mv $vscode_snippets/svg.code-snippets $backup_dir
echo -e "    › keybindings.json: $vscode → $backup_dir"
# mv $vscode/keybindings.json $backup_dir
echo -e "    › settings.json: $vscode → $backup_dir"
# mv $vscode/settings.json $backup_dir

# # Create symlinks
# echo "Creating symlink to .aliases.sh in ~/..."
# ln -sf ~/mac-os-setup/zsh/.aliases.sh ~/.aliases.sh
# echo "Creating symlink to .functions.sh in ~/..."
# ln -sf ~/mac-os-setup/zsh/.functions.sh ~/.functions.sh