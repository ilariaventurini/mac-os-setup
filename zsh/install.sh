#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
preferences=~/Library/Preferences
backup_dir=~/mac-os-setup-backup/zsh/zsh_$current_date

#-------------------------------------
# Install
#-------------------------------------

echo -e "\n› Installing zsh..."
brew install zsh
# it installs also dependencies `ncurses` and `pcre`

echo -e "› Set zsh as default shell..."
chsh -s $(which zsh) 

# Install oh-my-zsh
echo -e "\n› Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# now inside the `/ilariaventurini` folder you should have `.oh-my-zsh` and `.zshrc`

# Plugins
#-------------------------------------
# We are gonna to install oh-my-zsh plugins:
# - zsh-autosuggestions
# - zsh-completions
# - zsh-syntax-highlighting

echo -e "\n› Installing oh-my-zsh plugins"
echo -e "  › zsh-autosuggestions"
echo -e "  › zsh-completions"
echo -e "  › zsh-syntax-highlighting"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# this command creates the folder `zsh-autosuggestions` inside `.oh-my-zsh/custom/plugins`

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
# this command creates the folder `zsh-completions` inside `.oh-my-zsh/custom/plugins`

git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# this command creates the folder `zsh-syntax-highlighting` inside `.oh-my-zsh/custom/plugins`

# Theme
#-------------------------------------

echo -e "\n› Installing spaceships-prompt theme"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
# it creates the folder `spaceship-prompt` inside `.oh-my-zsh/custom/themes`

echo -e "› Creating a symlink of spaceship.zsh-theme to your oh-my-zsh custom themes directory..."
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#-------------------------------------
# Save old dotfiles in backup_dir and create symlinks
#-------------------------------------

echo -e "\n› Creating $backup_dir for backup of any existing dotfiles..."
mkdir -p $backup_dir

echo -e "\n› Move old dotfiles to $backup_dir and create symlinks..."

echo -e "  › .aliases.sh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.aliases.sh $backup_dir
echo -e "    › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.aliases.sh $home/.aliases.sh

echo -e "  › .functions.sh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.functions.sh $backup_dir
echo -e "    › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.functions.sh $home/.functions.sh

echo -e "  › .totest.sh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.totest.sh $backup_dir
echo -e "    › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.totest.sh $home/.totest.sh

echo -e "  › .spaceship.sh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.spaceship.sh $backup_dir
echo -e "    › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.spaceship.sh $home/.spaceship.sh

echo -e "  › .tab-title.sh"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.tab-title.sh $backup_dir
echo -e "    › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.tab-title.sh $home/.tab-title.sh

echo -e "  › .zshrc"
echo -e "    › move old file: $home → $backup_dir"
mv $home/.zshrc $backup_dir
echo -e "    › create symlink: $mos/zsh → $home"
ln -sf $mos/zsh/.zshrc $home/.zshrc