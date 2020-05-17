#!/bin/bash

current_date=`(date +%Y-%m-%d_%H%M%S)`

# Set variables
home=~/
mos=~/mac-os-setup
backup_dir=~/mac-os-setup-backup/homebrew/homebrew_$current_date

#-------------------------------------
# Homebrew 
# Homebrew is a free and open-source software package management system that 
# simplifies the installation of software on Apple's macOS operating system and Linux.
#-------------------------------------

echo -e "\n› Check if Homebrew is installed..."

if test ! $(which brew)
then
  echo "  Homebrew is not installed. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo -e "  Homebrew already installed. Updating..."
  brew update
fi
echo -e "  ➜ Ok"

# Now `/usr/local/` should contain:
# - `/usr/local/bin`
# - `/usr/local/Caskroom`
# - `/usr/local/Cellar`
# - `/usr/local/etc`
# - `/usr/local/Frameworks`
# - `/usr/local/Homebrew`
# - `/usr/local/include`
# - `/usr/local/lib`
# - `/usr/local/opt`
# - `/usr/local/sbin`
# - `/usr/local/share`
# - `/usr/local/var`

echo -e "\n› Upgrade any already-installed formulae..."
brew upgrade

# Check your system for potential problems
# brew doctor

# Lists installed Casks
# brew cask list

#-------------------------------------
# Install a lot of macOS formulae.
# The complete listing of all packages available from the core tap 
# via the Homebrew package manager for macOS: https://formulae.brew.sh/formula/
#-------------------------------------

echo -e "\n› Installing brew formulas:"
echo -e "  › node"
echo -e "  › exa"
echo -e "  › git"
echo -e "  › yarn"

brew install node # Platform built on V8 to build network applications
brew install exa # Modern replacement for 'ls'
brew install git # Distributed revision control system
brew install yarn # JavaScript package manager

echo -e "\n› Link formulas, so create symlinks from the installed package (located in /usr/local/Cellar) to /usr/local:"
echo -e "  › node"
brew link node

#-------------------------------------
# Install a lot of macOS casks.
# The complete listing of all casks available from the cask tap
# via the Homebrew package manager for macOS: https://formulae.brew.sh/cask/
#-------------------------------------

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

echo -e "\n› Installing brew cask formulas:"
echo -e "  › firefox"
echo -e "  › google-backup-and-sync"
echo -e "  › google-chrome"
echo -e "  › jdownloader"
echo -e "  › libreoffice"
echo -e "  › pdfsam-basic"
echo -e "  › runjs"
echo -e "  › sip"
echo -e "  › slack"
echo -e "  › sublime-text"
echo -e "  › telegram-desktop"
echo -e "  › visual-studio-code"
echo -e "  › vlc"
echo -e "  › whatsapp"

brew cask install ${HOMEBREW_CASK_OPTS} firefox
brew cask install ${HOMEBREW_CASK_OPTS} google-backup-and-sync
brew cask install ${HOMEBREW_CASK_OPTS} google-chrome
brew cask install ${HOMEBREW_CASK_OPTS} jdownloader # Free, open-source download management tool
brew cask install ${HOMEBREW_CASK_OPTS} libreoffice
brew cask install ${HOMEBREW_CASK_OPTS} pdfsam-basic # Desktop application to split, merge, extract pages, rotate and mix PDF files
brew cask install ${HOMEBREW_CASK_OPTS} runjs # A JavaScript playground that auto-evaluates as you type
brew cask install ${HOMEBREW_CASK_OPTS} sip # A better way to collect, organize & share your colors
brew cask install ${HOMEBREW_CASK_OPTS} slack
# brew cask install ${HOMEBREW_CASK_OPTS} spotmenu # Spotify and iTunes in your menu bar
brew cask install ${HOMEBREW_CASK_OPTS} sublime-text
brew cask install ${HOMEBREW_CASK_OPTS} telegram-desktop
brew cask install ${HOMEBREW_CASK_OPTS} visual-studio-code
brew cask install ${HOMEBREW_CASK_OPTS} vlc
brew cask install ${HOMEBREW_CASK_OPTS} whatsapp

#-------------------------------------
# Install fonts
#-------------------------------------

# echo -e "\n› Installing fonts:"
# echo -e "  › Inconsolata-Regular.ttf"
# echo -e "  › Inconsolata-Bold.ttf"

# cp ~/fonts/Inconsolata/Inconsolata-Regular.ttf ${HOMEBREW_CASK_OPTS} Inconsolata-Regular.ttf
# cp ~/fonts/Inconsolata/Inconsolata-Bold.ttf ${HOMEBREW_CASK_OPTS} Inconsolata-Bold.ttf

#-------------------------------------
# Cleanups
#-------------------------------------

echo -e "\n› Removing outdated versions from the cellar..."
brew cleanup
