#################################################################################
# Aliases
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#################################################################################

#-----------------
# Network
#-----------------

# Ip address
alias ip="echo Your ip is; dig +short myip.opendns.com @resolver1.opendns.com;"

#-----------------
# General aliases
#-----------------

alias ka9='killall -9'
alias k9='kill -9'

# Show/hide hidden files in Finder
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Lock the screen
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# Start the screensaver
alias screensaver="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

# Directory shortcuts
alias projects='cd ~/Projects/'
alias desktop='cd ~/Desktop/'
alias downloads='cd ~/Downloads/'
alias documents='cd ~/Documents/'
alias applications='cd ~/Applications/'
alias iv='cd ~/'
alias home='cd ~/'
# alias flutter='cd ~/flutter/'

# Get week number
alias week='date +%V'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ns_rsa.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_ns_rsa | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"

# Find all files in current dir/and subdirs modified in the last day
alias recently_modified="find . -type f -mtime -1 -not -path './.git/*'"

# Airport CLI alias
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

#-----------------
# Listing files
#-----------------

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# sexy list handling (https://the.exa.website/docs/command-line-options) using Exa
#   --long = Displays files in a table along with their metadata.
#   --header = Adds a header row to each column in the table.
#   --grid = Displays files as a grid.
#   --git = Lists each file’s Git status, if tracked.
#   --tree = Recurses into directories as a tree.
alias lsexa='exa --header --long --git'
alias lstree='exa --header --long --grid --git --tree'

#-----------------
# Oh my zsh customization
#-----------------

# Open .zshrc to be edited in VS Code
alias change="code ~/.zshrc"

# Re-run source command on .zshrc to update current terminal session with new settings
alias update="source ~/.zshrc"

#-----------------
# VS Code
#-----------------

# Save extensions list in ~/extensions.txt
alias vscode-extensions-save='code --list-extensions > ~/extensions.txt && echo Done!'

# Install extensions listed in ~/extensions.txt
alias vscode-extensions-install='xargs -n 1 code --install-extension < ~/extensions.txt'

#-----------------
# Python
#-----------------

alias python=/usr/bin/python3