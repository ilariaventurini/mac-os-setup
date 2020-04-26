#################################################################################
# iTerm status bar
# Showing the Node version and the pwd in your status bar.
# To work, you should have shell integration installed.
# See here: https://www.iterm2.com/documentation-shell-integration.html
#################################################################################

# https://www.iterm2.com/documentation-shell-integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# set variables for iterm status bar
iterm2_print_user_vars() {
  # extend this to add whatever you want to have printed out in the status bar
  iterm2_set_user_var nodeVersion $(node -v)
  iterm2_set_user_var pwd $(pwd)
}