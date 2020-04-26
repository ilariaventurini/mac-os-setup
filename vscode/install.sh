#!/bin/bash


# Check if Visual Studio Code is installed
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"

if [! -d '/Applications/Visual Studio Code.app' -a ! -d "$HOME/Applications/Visual Studio Code.app"]
then
  echo 'Visual Studio Code is not installed. Installing it...'
  brew cask install ${HOMEBREW_CASK_OPTS} visual-studio-code
  echo "...done"
fi
echo "Visual Studio Code already installed."

# Install extensions listed in ~/extensions.txt
echo "Installing extensions..."
xargs -n 1 code --install-extension < ~/mac-os-setup/vscode/extensions.txt
echo "...done"