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

# Ping Google 5 times
alias ping-google-5-times="ping -c 5 google.com"

#-----------------
# General aliases
#-----------------

# Get date
alias get-now-date-time='date +"%Y-%m-%d %T"'

# Show epoch timestamp
alias get-epoch-timestamp='date +"%s"'

alias force-kill-by-process-name='killall -9'
alias force-kill-by-process-id='kill -9'

# Show/hide hidden files in Finder
alias show-hidden-files="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide-hidden-files="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Directory shortcuts
alias go-to-desktop='cd ~/Desktop/'
alias go-to-downloads='cd ~/Downloads/'
alias go-to-documents='cd ~/Documents/'
alias go-to-applications='cd ~/Applications/'
alias go-to-ilariaventurini='cd ~/'
alias go-to-home='cd ~/'

# Get week number
alias get-week-number='date +%V'

# Recursively delete `.DS_Store` files
alias recursively-delete-ds-store-files="find . -type f -name '*.DS_Store' -ls -delete"

# rm -i FILE: deletes the file. 
# With -i, it prompts before each removal. After it’s removed, it’s not in the filesystem anymore (no “undo” unless you have backups/FS snapshots; it does not go to Trash)
alias rm='rm -i'
# mv -i SRC DEST: moves/renames the file. 
# With -i, it prompts only if the destination exists and would be overwritten. If you move within the same disk, it’s typically just a rename; you can usually “undo” by moving it back
alias mv='mv -i'
# cp -i SRC DEST: copies SRC to DEST. 
# If DEST exists, it prompts before replacing it. The original SRC remains.
alias cp='cp -i'
# mv -i SRC DEST: moves/renames SRC to DEST. 
# If DEST exists, it prompts before overwriting it. After a successful move, SRC is gone from the original location
alias ln='ln -i'

#-----------------
# Listing files
#-----------------

# List all files colorized in long format
alias list-all-files="ls -lF"

# List all files colorized in long format, including dot files
alias list-all-files-including-dot-files="ls -laF"

# List only directories
alias list-only-directories="ls -lF | grep --color=never '^d'"

#-----------------
# Oh my zsh customization
#-----------------

# Open .zshrc to be edited in VS Code
alias edit-zshrc="code ~/.zshrc"

# Re-run source command on .zshrc to update current terminal session with new settings
alias source-zshrc="source ~/.zshrc"

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

alias java-17="export JAVA_HOME=`/usr/libexec/java_home -v 17`; java -version"
