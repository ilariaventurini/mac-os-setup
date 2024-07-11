# Necessary to skip verification of insecure directories
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ilariaventurini/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

#----------------------------------
# Theme
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#----------------------------------
ZSH_THEME="spaceship"
source $HOME/.spaceship.sh

#----------------------------------
# Plugins
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#----------------------------------

plugins=(
  # bower
  # extract
  git
  # yarn
  # node
  # npm
  # z
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

# needed by zsh-completions plugin to reloading the completion
autoload -U compinit && compinit

#----------------------------------
# oh-my-zsh
#----------------------------------
source $ZSH/oh-my-zsh.sh

#----------------------------------
# Aliases
#----------------------------------
source $HOME/.aliases.sh
source $HOME/.functions.sh

#----------------------------------
# Tab title
# Set tab title as the current path.
#----------------------------------
source $HOME/.tab-title.sh

#----------------------------------
# iTerm status bar
# Showing the Node version and the pwd in your status bar.
# To work, you should have shell integration installed.
# See here: https://www.iterm2.com/documentation-shell-integration.html
#----------------------------------
source $HOME/.iterm.sh

#----------------------------------
# !! Scripts to test !!
#----------------------------------
# source $HOME/.totest.sh


#----------------------------------
# Android Studio
#----------------------------------
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# export ANDROID_HOME=/Users/$USER/Library/Android/sdk
# export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/<your-flutter-path>/bin

#----------------------------------
# Flutter
#----------------------------------
export PATH="$PATH:$HOME/flutter/bin"
# export SDKROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.3.sdk


#----------------------------------
# Java
#----------------------------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#----------------------------------
# Google Cloud SDK
#----------------------------------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ilariaventurini/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ilariaventurini/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ilariaventurini/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ilariaventurini/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/lib/google-cloud-sdk/bin:$PATH"

