#################################################################################
# Tab title
#################################################################################

#-----------------
# Refresh the custom title when the directory changes
#-----------------
function chpwd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}
# Let zsh launch with the custom title
chpwd # call the function

#-----------------
# Set the tab title to the current working directory before each prompt
# to use type `tabTitle`
#-----------------
function tabTitle () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}

#-----------------
# Set the tab title as you want
# to use type `setTitle I want a cat!`
#-----------------
function setTitle {
    echo -ne "\033]0;"$*"\007"
}

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"