#!/bin/bash

#-------------------------------------
# Homebrew 
# Homebrew is a free and open-source software package management system that 
# simplifies the installation of software on Apple's macOS operating system and Linux.
#-------------------------------------

# Install Homebrew

echo "Check if Homebrew is installed..."

if test ! $(which brew)
then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo "...done"
else
  echo "Updating Homebrew..."
  # Make sure we’re using the latest Homebrew
  brew update
fi

# Upgrade any already-installed formulae
brew upgrade

# Check the version type
brew -v

# Check your system for potential problems
# brew doctor

# Lists installed Casks
# brew cask list

#-------------------------------------
# Install a lot of macOS formulae.
# The complete listing of all packages available from the core tap 
# via the Homebrew package manager for macOS: https://formulae.brew.sh/formula/
#-------------------------------------

echo 'Installing brew formulas...'

brew install mas # Mac App Store manager
brew install node # Platform built on V8 to build network applications
brew install exa # Modern replacement for 'ls'
brew install git # Distributed revision control system
brew install yarn # JavaScript package manager
brew install stow # Organize software neatly under a single directory tree (e.g. /usr/local)
brew install zsh # UNIX shell (command interpreter)
brew install zsh-autosuggestions # Fish-like fast/unobtrusive autosuggestions for zsh
brew install zsh-completions # Additional completion definitions for zsh
brew install zsh-git-prompt # Informative git prompt for zsh
brew install zsh-history-substring-search # Zsh port of Fish shell's history search
brew install zsh-lovers # Tips, tricks, and examples for zsh
brew install zsh-navigation-tools # Zsh curses-based tools, e.g. multi-word history searcher
brew install zsh-syntax-highlighting # 	Fish shell like syntax highlighting for zsh

brew link node

echo "...done"

#-------------------------------------
# Install oh-my-zsh using curl.
#-------------------------------------
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#-------------------------------------
# Install a lot of macOS casks.
# The complete listing of all casks available from the cask tap
# via the Homebrew package manager for macOS: https://formulae.brew.sh/cask/
#-------------------------------------

echo 'Installing brew cask formulas...'

# `brew tap` adds more repos to the list of formulae that brew tracks, updates, and installs from.
# If your tap contains a formula that is also present in `homebrew/core`, that's fine, 
# but it means that you must install it explicitly by default.
# Whenever a `brew install foo` command is issued, brew will find which formula to use by searching in the following order:
#   - core formulae
#   - other taps
# If you need a formula to be installed from a particular tap, you can use fully qualified names to refer to them.

# List all the taps
# brew tap

# Specify your defaults in this environment variable
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"

brew cask install ${HOMEBREW_CASK_OPTS} firefox
brew cask install ${HOMEBREW_CASK_OPTS} fork # A fast and friendly git client for Mac and Windows
brew cask install ${HOMEBREW_CASK_OPTS} google-backup-and-sync
brew cask install ${HOMEBREW_CASK_OPTS} google-chrome
brew cask install ${HOMEBREW_CASK_OPTS} iterm2
brew cask install ${HOMEBREW_CASK_OPTS} jdownloader # Free, open-source download management tool
brew cask install ${HOMEBREW_CASK_OPTS} libreoffice
brew cask install ${HOMEBREW_CASK_OPTS} pdfsam-basic # Desktop application to split, merge, extract pages, rotate and mix PDF files
brew cask install ${HOMEBREW_CASK_OPTS} runjs # A JavaScript playground that auto-evaluates as you type
brew cask install ${HOMEBREW_CASK_OPTS} sip # A better way to collect, organize & share your colors
brew cask install ${HOMEBREW_CASK_OPTS} slack
brew cask install ${HOMEBREW_CASK_OPTS} spotify
brew cask install ${HOMEBREW_CASK_OPTS} spotmenu # Spotify and iTunes in your menu bar
brew cask install ${HOMEBREW_CASK_OPTS} sublime-text
brew cask install ${HOMEBREW_CASK_OPTS} telegram-desktop
brew cask install ${HOMEBREW_CASK_OPTS} visual-studio-code
brew cask install ${HOMEBREW_CASK_OPTS} vlc
brew cask install ${HOMEBREW_CASK_OPTS} whatsapp

echo "...done"

#-------------------------------------
# Install fonts
#-------------------------------------

# echo 'Installing fonts...'

# cp ~/fonts/Inconsolata/Inconsolata-Regular.ttf ${HOMEBREW_CASK_OPTS} Inconsolata-Regular.ttf
# cp ~/fonts/Inconsolata/Inconsolata-Bold.ttf ${HOMEBREW_CASK_OPTS} Inconsolata-Bold.ttf

# echo '...done'

#-------------------------------------
# Cleanups
#-------------------------------------

echo 'Removing outdated versions from the cellar...'

# Remove outdated versions from the cellar.
brew cleanup

echo '...done'
