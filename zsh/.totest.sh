# Mix of aliases and functions to test and eventually add to aliases.sh or functions.sh or a new file

############################
# ALIASES
############################

# Confirmation because I like to be safe...
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Ping
alias ping="ping -c 5"
alias pinggoogle="ping google.com -c 5"

# Exit commands
alias bye="exit"
alias die="exit"
alias quit="exit"

# Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# # Extensions
# alias -s avi=vlc
# alias -s html=$BROWSER
# alias -s pdf=epdfview
# alias -s txt=$EDITOR
# alias -s text=$EDITOR

# # Images
# alias -s png=feh
# alias -s jpeg=feh
# alias -s jpg=feh
# alias -s gif=feh

# # Source Extensions
# alias -s hs=$EDITOR
# alias -s c=$EDITOR

# Get top process eating cpu
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"

# Gets the total disk usage on your machine
alias totaldiskusage='df -hl --total | grep total'

# Shows the individual partition usages without the temporary memory values
alias partdiskusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'

# Gives you what is using the most space. Both directories and files. Varies on current directory
alias most='du -hsx * | sort -rh | head -10'

# Open from command line
alias finder='open -a Finder '

# Get date
alias now='date +"%Y-%m-%d %T"'

# Show epoch timestamp
alias epoch='date +"%s"'

# System state
alias reboot="sudo /sbin/reboot"
alias poweroff="sudo /sbin/poweroff"
alias halt="sudo /sbin/halt"
alias shutdown="sudo /sbin/shutdown"
alias flighton='sudo rfkill block all'
alias flightoff='sudo rfkill unblock all'
alias snr='sudo service network-manager restart'

alias NE="2>/dev/null"

############################
# FUNCTIONS
############################

# Automatically run ls when cd-ing into a directory
function cd() {
  builtin cd $* && ls;
}

# Add coloring to man pages
# Source: https://wiki.archlinux.org/index.php/man_page#Colored_man_pages
function man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# get the name of the branch we are on
function git_prompt_info() {
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  local GIT_STATUS=''
  local CLEAN_MESSAGE='nothing to commit (working directory clean)'
  if [[ "$(command git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
          SUBMODULE_SYNTAX="--ignore-submodules=dirty"
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} -uno 2> /dev/null | tail -n1)
    else
        GIT_STATUS=$(command git status -s ${SUBMODULE_SYNTAX} 2> /dev/null | tail -n1)
    fi
    if [[ -n $GIT_STATUS ]]; then
      echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the difference between the local and remote branches
function git_remote_status() {
    remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
    if [[ -n ${remote} ]] ; then
        ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
        behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE"
        fi
    fi
}

# save a file to ~/tmp
function saveit() {
  cp $1 ${HOME}/tmp/${1}.saved
}

# View most commonly used commands. depends on your history output format
function used() {
  if [ $1 ]
  then
      history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n $1
  else
      history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n 10
  fi
}

#if dir,cd into it. if file ,cd into where the file is
function goto() { 
  [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; 
}

function mvtmp() {
  mv $1 ~/tmp/
}

function cptmp(){
  cp -r $1 ~/tmp/
}

function current_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  current_branch=${ref#refs/heads/}

  # warn me if not working on master
  if [[ "${current_branch}" == "master" ]]; then
    echo "${C_GREEN}${current_branch}${C_RESET}"
  elif [[ -z "${current_branch}" ]]; then
    echo "${C_RED}detached${C_RESET}"
  else
    echo "${C_YELLOW}${current_branch}${C_RESET}"
  fi
}

function minutes_since_last_commit {
    now=`date +%s`
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null) || return
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}

# rendering git prompt if we are in a git repo
function git_prompt {
    $(git rev-parse --is-inside-work-tree 2> /dev/null) || return
    echo "($(current_git_branch))${extra_info}"
}

function git-author() {
  args=(${@})
  case ${1} in
    set)
      export GIT_AUTHOR_NAME=${args[@]:1:2}
      ;;
    unset)
      unset GIT_AUTHOR_NAME
      ;;
    show|get)
      echo "Current authors: ${GIT_AUTHOR_NAME:-$(git config --get user.name)}"
      ;;
    *)
      echo "Usage git-author [set AUTHORS|unset|show|get]"
      git-author show
      ;;
  esac
}
