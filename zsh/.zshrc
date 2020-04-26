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

