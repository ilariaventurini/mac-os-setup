#!/bin/bash

echo "WELCOME!"

# Install a lot of things using Homebrew
chmod +rx brew.sh
./brew.sh

# Install things from App store
# - RunCat
chmod +rx install-from-app-store.sh
./install-from-app-store.sh

# Download softwares to install manually
# - Logitech Options
# - uTorrent
chmod +rx download-files.sh
./download-files.sh

# Creates symlinks from home directory to any desired dotfiles in ~/dotfiles
# chmod +x make-symlinks.sh # make the script executable
chmod +rx make-symlinks.sh
./dotfiles/make-symlinks.sh

# Set MacOS defaults
chmod +rx macos-settings.sh
./macos/macos-settings.sh



