#!/bin/bash

# Install zsh
echo "Installing zsh..."
brew install zsh
echo "...done"
# it installs also dependencies `ncurses` and `pcre`

# Change the default shell to Zsh
echo "Set zsh as default shell..."
chsh -s $(which zsh) 
echo "...done"

# Install oh-my-zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "...done"
# now inside the `/ilariaventurini` folder you should have `.oh-my-zsh` and `.zshrc`

############## 
# Plugins
##############
# We are gonna to install oh-my-zsh plugins:
# - zsh-autosuggestions
# - zsh-completions
# - zsh-syntax-highlighting

echo "Installing zsh-autosuggestions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "...done"
# this command creates the folder `zsh-autosuggestions` inside `.oh-my-zsh/custom/plugins`

echo "Installing zsh-completions plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "...done"
# this command creates the folder `zsh-completions` inside `.oh-my-zsh/custom/plugins`

echo "Installing zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo "...done"
# this command creates the folder `zsh-syntax-highlighting` inside `.oh-my-zsh/custom/plugins`

############## 
# Theme
##############

echo "Installing spaceships-prompt theme..."
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
echo "...done"
# it creates the folder `spaceship-prompt` inside `.oh-my-zsh/custom/themes`

echo "Creating a symlink of spaceship.zsh-theme to your oh-my-zsh custom themes directory..."
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
echo "...done"

########################################################################
########################################################################
########################################################################

# pwd=$PWD # current directory, ie /Users/ilariaventurini/mac-os-setup
# olddir=~/dotfiles_zsh_old # old dotfiles backup directory
# echo ${pwd}
# echo ${olddir}

# # Go to home directory
# echo "=> Changing to the ~/ directory"
# cd ~/
# echo "...done"

# # Create olddir in homedir
# echo "=> Creating $olddir for backup of any existing dotfiles in ~/..."
# mkdir -p $olddir
# echo "...done"

# # Change to the dotfiles directory
# echo "=> Changing to the ~/mac-os-setup/zsh directory"
# cd ~/mac-os-setup/zsh
# echo "...done"

# # Move any existing dotfiles in homedir to olddir directory
# echo "=> Moving .aliases.sh from ~/ to $olddir"
# mv ~/.aliases.sh $olddir
# echo "=> Moving .functions.sh from ~/ to $olddir"
# mv ~/.functions.sh $olddir

# # Create symlinks
# echo "Creating symlink to .aliases.sh in ~/..."
# ln -sf ~/mac-os-setup/zsh/.aliases.sh ~/.aliases.sh
# echo "Creating symlink to .functions.sh in ~/..."
# ln -sf ~/mac-os-setup/zsh/.functions.sh ~/.functions.sh
