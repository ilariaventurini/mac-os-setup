#################################################################################
# Aliases
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#################################################################################

#-------------------------------------
# General aliases
#-------------------------------------

# ip address
alias ip="echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

# directory short cuts
alias projects='cd ~/Projects/'
alias desktop='cd ~/Desktop/'
alias downloads='cd ~/Downloads/'
alias documents='cd ~/Documents/'
alias applications='cd ~/Applications/'
alias iv='cd ~/'
alias home='cd ~/'

# sexy list handling (https://the.exa.website/docs/command-line-options) using Exa
#   --long = Displays files in a table along with their metadata.
#   --header = Adds a header row to each column in the table.
#   --grid = Displays files as a grid.
#   --git = Lists each file’s Git status, if tracked.
#   --tree = Recurses into directories as a tree.
alias lsexa='exa --header --long --git'
alias lstree='exa --header --long --grid --git --tree'

# open .zshrc to be edited in VS Code
alias change="code ~/.zshrc"
# re-run source command on .zshrc to update current terminal session with new settings
alias update="source ~/.zshrc"

# show/hide hidden files in Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# run a screensaver on the Desktop
alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#-------------------------------------
# Git aliases
#-------------------------------------