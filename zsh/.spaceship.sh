#################################################################################
# Spaceship theme customization
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
#################################################################################

#-----------------
# You can specify the order of prompt section using SPACESHIP_PROMPT_ORDER option.
# The order also defines which sections that Spaceship loads. If you're struggling with slow prompt, you can just omit the sections that you don't use, and they won't be loaded.
#-----------------

SPACESHIP_PROMPT_ORDER=(
  # time          # Time stamps section
  # user          # Username section
  # dir           # Current directory section
  # host          # Hostname section
  # git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  # package       # Package version
  # node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  # venv          # virtualenv section
  # conda         # conda virtualenv section
  # pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubecontext   # Kubectl context section
  # terraform     # Terraform workspace section
  # exec_time     # Execution time
  # line_sep      # Line break
  # battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  # jobs          # Background jobs indicator
  # exit_code     # Exit code section
  # char          # Prompt character
)

#-----------------
# You can also add items to the right prompt by specifying them in the SPACESHIP_RPROMPT_ORDER option. 
# By default SPACESHIP_RPROMPT_ORDER is empty.
#-----------------

SPACESHIP_RPROMPT_ORDER=(
)

#-----------------
# Prompt
#-----------------

# Adds a newline character before each prompt line
SPACESHIP_PROMPT_ADD_NEWLINE="true"	
# Make the prompt span across two lines
SPACESHIP_PROMPT_SEPARATE_LINE="true"	
# Shows a prefix of the first section in prompt
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="false"
# Show prefixes before prompt sections or not	
SPACESHIP_PROMPT_PREFIXES_SHOW="true"	
# Show suffixes before prompt sections or not
SPACESHIP_PROMPT_SUFFIXES_SHOW="true"
# Default prefix for prompt sections	
SPACESHIP_PROMPT_DEFAULT_PREFIX=" "
# Default suffix for prompt section
SPACESHIP_PROMPT_DEFAULT_SUFFIX=" "

#-----------------
# Char
#-----------------

# Prefix before prompt character
SPACESHIP_CHAR_PREFIX=" "
# Suffix after prompt character
SPACESHIP_CHAR_SUFFIX=" " 	
# Prompt character to be shown before any command
SPACESHIP_CHAR_SYMBOL="➜"	
# Prompt character to be shown before any command for the root user
SPACESHIP_CHAR_SYMBOL_ROOT=$SPACESHIP_CHAR_SYMBOL	
# Secondary prompt character to be shown for incomplete commands
SPACESHIP_CHAR_SYMBOL_SECONDARY=$SPACESHIP_CHAR_SYMBOL
# Color of prompt character if last command completes successfully	
SPACESHIP_CHAR_COLOR_SUCCESS="green"
# Color of prompt character if last command returns non-zero exit-code
SPACESHIP_CHAR_COLOR_FAILURE="red"	
# Color of secondary prompt character
SPACESHIP_CHAR_COLOR_SECONDARY="yellow"	

#-----------------
# Time (time)
# Disabled by default. Set SPACESHIP_TIME_SHOW to true in your .zshrc, if you need to show time stamps.
#-----------------

SPACESHIP_TIME_SHOW="true"
# Show time (set to true for enabling)
SPACESHIP_TIME_SHOW="false"	
# Prefix before time section
SPACESHIP_TIME_PREFIX="at "	
# Suffix after time section
SPACESHIP_TIME_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
# Color of time section
SPACESHIP_TIME_COLOR="yellow"
# Custom date formatting ZSH date format
SPACESHIP_TIME_FORMAT="false"
# Format time using 12-hour clock (am/pm)	
SPACESHIP_TIME_12HR="false"

#-----------------
# Username (user)
# By default, a username is shown only when it's not the same as $LOGNAME, when you're connected via SSH or when you're root. 
# Root user is highlighted in SPACESHIP_USER_COLOR_ROOT color (red as default).
#-----------------

# Show user section (true, false, always or needed)
SPACESHIP_USER_SHOW="true"	
# Prefix before user section
SPACESHIP_USER_PREFIX="with "	
# Suffix after user section
SPACESHIP_USER_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
# Color of user section
SPACESHIP_USER_COLOR="yellow"	
# Color of user section when it's root
SPACESHIP_USER_COLOR_ROOT="red"	

# SPACESHIP_USER_SHOW defines when to show username section. 
# Here are possible values:
# - SPACESHIP_USER_SHOW="false"
#     Show on local = never	
#     Show on remote = never
# - SPACESHIP_USER_SHOW="always"
#     Show on local = always	
#     Show on remote = always
# - SPACESHIP_USER_SHOW="true"
#     Show on local = if needed	
#     Show on remote = always
# - SPACESHIP_USER_SHOW="needed"
#     Show on local = if needed	
#     Show on remote = if needed

#-----------------
# Hostname (host)
# Hostname is shown only when you're connected via SSH unless you change this behavior.
#-----------------

# Show host section (true, false or always)
SPACESHIP_HOST_SHOW="true"	
# Show full hostname section (true, false)
SPACESHIP_HOST_SHOW_FULL="false"	
# Prefix before the connected SSH machine name
SPACESHIP_HOST_PREFIX="@:("
# uffix after the connected SSH machine name
SPACESHIP_HOST_SUFFIX=") "
# Color of host section
SPACESHIP_HOST_COLOR="blue"	
# Color of host in SSH connection
SPACESHIP_HOST_COLOR_SSH="green"	

#-----------------
# Directory (dir)
# Directory is always shown and truncated to the value of SPACESHIP_DIR_TRUNC. 
# While you are in repository, it shows only root directory and folders inside it. 
# If current directory is write-protected or if current user has not enough rights to write in it, a padlock (by default) is displayed as a suffix.
#-----------------

# Show directory section
SPACESHIP_DIR_SHOW="true"
# Prefix before current directory
SPACESHIP_DIR_PREFIX="in "
# Suffix after current directory
SPACESHIP_DIR_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
# Number of folders of cwd to show in prompt, 0 to show all
SPACESHIP_DIR_TRUNC="3"
# Prefix before cwd when it's truncated. For example …/ or .../, empty to disable
SPACESHIP_DIR_TRUNC_PREFIX=" "
# While in git repo, show only root directory and folders inside it
SPACESHIP_DIR_TRUNC_REPO="true"
# Color of directory section
SPACESHIP_DIR_COLOR="cyan"
# The symbol displayed if directory is write-protected (requires powerline patched font)
SPACESHIP_DIR_LOCK_SYMBOL=" "
# Color for the lock symbol
SPACESHIP_DIR_LOCK_COLOR="red"

#-----------------
# Git (git)
# Git section is consists with git_branch and git_status subsections. 
# It is shown only in Git repositories.
#-----------------

# Show Git section
SPACESHIP_GIT_SHOW="true"	
# Prefix before Git section
SPACESHIP_GIT_PREFIX="on "	
# Suffix after Git section
SPACESHIP_GIT_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX	
# Character to be shown before Git section (requires powerline patched font
SPACESHIP_GIT_SYMBOL=" "	

#.......
# Git branch (git_branch)
#.......

# Show Git branch subsection
SPACESHIP_GIT_BRANCH_SHOW="true" 
# Prefix before Git branch subsection
SPACESHIP_GIT_BRANCH_PREFIX=$SPACESHIP_GIT_SYMBOL	
# Suffix after Git branch subsection
SPACESHIP_GIT_BRANCH_SUFFIX=" "
# Color of Git branch subsection
SPACESHIP_GIT_BRANCH_COLOR="magenta"	

#.......
# Git status (git_status)
# Git status indicators is shown only when you have dirty repository.
#.......

# Show Git status subsection
SPACESHIP_GIT_STATUS_SHOW="true"	
# Prefix before Git status subsection
SPACESHIP_GIT_STATUS_PREFIX=" ["
# Suffix after Git status subsection	
SPACESHIP_GIT_STATUS_SUFFIX="]"	
# Color of Git status subsection
SPACESHIP_GIT_STATUS_COLOR="red"	
# Indicator for untracked changes
SPACESHIP_GIT_STATUS_UNTRACKED="?"
# Indicator for added changes	
SPACESHIP_GIT_STATUS_ADDED="+"	
# Indicator for unstaged files
SPACESHIP_GIT_STATUS_MODIFIED="!"	
# Indicator for renamed files
SPACESHIP_GIT_STATUS_RENAMED="»"	
# Indicator for deleted files
SPACESHIP_GIT_STATUS_DELETED="✘"	
# Indicator for stashed changes
SPACESHIP_GIT_STATUS_STASHED="$"	
# Indicator for unmerged changes
SPACESHIP_GIT_STATUS_UNMERGED="="
# Indicator for unpushed changes (ahead of remote branch)	
SPACESHIP_GIT_STATUS_AHEAD="⇡"	
# Indicator for unpulled changes (behind of remote branch)
SPACESHIP_GIT_STATUS_BEHIND="⇣"	
# Indicator for diverged changes (diverged with remote branch)
SPACESHIP_GIT_STATUS_DIVERGED="⇕"	

#-----------------
# Execution time (exec_time)
# Execution time of the last command. Will be displayed if it exceeds the set threshold of time.
#-----------------

# Show execution time
SPACESHIP_EXEC_TIME_SHOW="true"	
# Prefix before execution time section
SPACESHIP_EXEC_TIME_PREFIX="took "	
# Suffix after execution time section
SPACESHIP_EXEC_TIME_SUFFIX=$SPACESHIP_PROMPT_DEFAULT_SUFFIX
# Color of execution time section
SPACESHIP_EXEC_TIME_COLOR="yellow"
# The minimum number of seconds for showing execution time section
SPACESHIP_EXEC_TIME_ELAPSED="2"	