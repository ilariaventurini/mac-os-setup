#!/bin/bash
#-------------------------------------
# That is called a `shebang`, it tells the shell what program to interpret 
# the script with, when executed.
# In this case, the script is to be interpreted and run by the bash shell.
#-------------------------------------

# Install a lot of thing using Homebrew
./brew.sh

# Creates symlinks from home directory to any desired dotfiles in ~/dotfiles
./make-symlinks.sh

# Set MacOS defaults
# ./macos.sh

#-------------------------------------
# Something I don't understand.
#-------------------------------------
# # Generate ssh key
# ssh-keygen -t rsa -b 4096 -C "venturini.ila@gmail.com"

# # Copy ssh and wait for user to insert it in github
# pbcopy < ~/.ssh/id_rsa.pub
# echo "Now login to https://github.com/settings/keys and add the key that has already been copied to your clipboard."
# read -p "Press any key to continue or Ctrl-C to abort."

# # Remove password from sudo
# echo "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# # Install xcode command line tools
# xcode-select --install
