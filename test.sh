#!/bin/bash

echo -e "\nSetting macOS defaults..."

# Check that you are not running this script as root
echo -e "\n› Check that you are not running this script as root..."
if [[ $EUID -eq 0 ]]; then
  clear
  echo -ne '\007'
  echo -e "  ✕ Error: This script must NOT be run as root" 1>&2
  sudo -k
  exit 1
fi
echo -e "  ➜ Ok"

# To avoid having the user respond to prompts at different times throughout the execution of this Bash script, 
# the following AppleScripts – when run – will ensure that authority is given up-front.
echo -e "\n› Give me authority for Finder, Script Editor, System Events and System Preferences..."
osascript -e 'tell app "Finder" to display notification "Terminal has been granted access to control Finder.app" with title "Pardon My Appearance"' > /dev/null 2>&1
osascript -e 'tell app "Script Editor" to display notification "Terminal has been granted access to control Script Editor.app" with title "Pardon My Appearance"' > /dev/null 2>&1
osascript -e 'tell app "System Events" to display notification "Terminal has been granted access to control System Events.app" with title "Pardon My Appearance"' > /dev/null 2>&1
osascript -e 'tell app "System Preferences" to display notification "Terminal has been granted access to control System Preferences.app" with title "Pardon My Appearance"' > /dev/null 2>&1
echo -e "  ➜ Ok"

echo -e "\n› Check if GUI Scripting is enabled..."
osascript > /dev/null 2>&1 <<EOD
  # check to see if assistive devices is enabled
	tell application "System Events"
		set UI_enabled to UI elements enabled
	end tell
	if UI_enabled is false then
		tell application "System Preferences"
			activate
			set current pane to pane id "com.apple.preference.security"
			reveal anchor "Privacy_Assistive" of pane id "com.apple.preference.security"
			display dialog "This script utilizes the built-in Graphical User Interface Scripting architecture of macOS which is currently disabled." & return & return & "You can enable GUI Scripting by checking  \"Script Editor\", \"Terminal\" and/or \"iTerm\" in System Preferences > Security & Privacy > Privacy > Accessibility." with icon 1 buttons {"Cancel"} default button 1 giving up after 200
		end tell
	end if
  #tell application "Terminal" to activate
EOD

ExitCode=$?

# If GUI Scripting is not enabled, the AppleScript above exits with a code of 1 and we do not want to continue
if [[ $ExitCode -eq 1 ]]; then
  echo -ne '\007'
  clear
  echo "  ✕ Error: GUI Scripting is not enabled. Go to System Preferences → Security & Privacy → Privacy tab → Accessibility → check iTerm.app."
  exit 1
fi
echo -e "  ➜ Ok"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
echo -e "\n› Close any open System Preferences panes, to prevent them from overriding settings we’re about to change..."
osascript -e 'tell application "System Preferences" to quit'
echo -e "  ➜ Ok"

# Ask for the administrator password upfront
echo -e "\n› Ask for the administrator password..."
sudo -v
echo -e "  ➜ Ok"

# Keep-alive: update existing `sudo` time stamp until this script has finished
echo -e "\n› Update existing 'sudo' timestamp until this script has finished..."
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null
echo -e "  ➜ Ok"

#-------------------------------------
# System preferences 
#-------------------------------------

echo -e "\n› Configuring System Preferences"

# General 
#-------------------------------------

echo -e "\n  › System Preferences → General"

# Dark (for this mode "AppleInterfaceStyleSwitchesAutomatically" mustn't exist so delete it)
echo -e "    › Appearance: Dark"
defaults write -g AppleInterfaceStyle -string Dark
defaults delete -g AppleInterfaceStyleSwitchesAutomatically 2> /dev/null # Defaults throws an error if the key does not exist, so write STDERR to /dev/null to surpress error messages

# Accent colour: Blue
echo -e "    › Accent colour: Blue"
defaults delete -g AppleAccentColor 2> /dev/null

# Highlight colour: Blue
echo -e "    › Highlight colour: Blue"
defaults delete -g AppleHighlightColor 2> /dev/null 
defaults write -g AppleAquaColorVariant -int 1

# Set sidebar icon size to medium (small = 1, medium = 2, large = 3)
echo -e "    › Sidebar icon size: Medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Do not automatically hide and show the menu bar
echo -e "    › Automatically hide and show the menu bar: false"
defaults write -g _HIHideMenuBar -bool false

# Always show scrollbars
# Possible values: `WhenScrolling`, `Automatic` and `Always`
echo -e "    › Show scroll bars: Always"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Click in the scroll bar to: Jump to the next page
echo -e "    › Click in the scroll bar to: Jump to the next page"
defaults write -g AppleScrollerPagingBehavior -bool false

# # Set default browser
# echo -e "    › Default web browser: Google Chrome.app"

# Ask keep changes when closing documents: unchecked
echo -e "    › Ask keep changes when closing documents: false"
defaults write -g NSCloseAlwaysConfirmsChanges -bool false

# Close windows when quitting an app: unchecked
echo -e "    › Close windows when quitting an app: false"
defaults write -g NSQuitAlwaysKeepsWindows -bool false

# # Set default browser
# echo -e "    › Recent items: 10"

# # Set default browser
# echo -e "    › Allow Handoff between this Mac and your iCloud devices: true"

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
echo -e "    › Use font smoothing when available: true"
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Desktop & Screen Saver  
#-------------------------------------

echo -e "\n  › System Preferences → Desktop & Screen Saver"

# # Hot corners
# # Possible values:
# #    0: no-op
# #    2: Mission Control
# #    3: Show application windows
# #    4: Desktop
# #    5: Start screen saver
# #    6: Disable screen saver
# #    7: Dashboard
# #   10: Put display to sleep
# #   11: Launchpad
# #   12: Notification Center
# #   13: Lock Screen
# echo -e "    › Hot Corners"
# # Top left screen corner: Mission Control
# echo -e "      › Top left screen corner:  Mission Control"
# defaults write com.apple.dock wvous-tl-corner -int 2
# defaults write com.apple.dock wvous-tl-modifier -int 0
# # Top right screen corner: Desktop
# echo -e "      › Top right screen corner: Desktop"
# defaults write com.apple.dock wvous-tr-corner -int 4
# defaults write com.apple.dock wvous-tr-modifier -int 0
# # Bottom left screen corner: Start screen saver
# echo -e "      › Bottom left screen corner: Start screen saver"
# defaults write com.apple.dock wvous-bl-corner -int 5
# defaults write com.apple.dock wvous-bl-modifier -int 0
# echo -e "      › Bottom right screen corner: Start screen saver"
# defaults write com.apple.dock wvous-br-corner -int 5
# defaults write com.apple.dock wvous-br-modifier -int 0

# Dock 
#-------------------------------------

echo -e "\n  › System Preferences → Dock"

echo -e "    › Size: Small"
echo -e "    › Magnification: false"
echo -e "    › Magnification: Max"
echo -e "    › Position on screen: Bottom"
echo -e "    › Minimise windows using: Genie effect"
echo -e "    › Prefer tabs when opening docuements: Always"
echo -e "    › Double-click a window’s title bar to: true"
echo -e "    › Double-click a window’s title bar to: Zoom"
echo -e "    › Minimise windows into application icon: false"
echo -e "    › Animate opening applications: true"
echo -e "    › Automatically hide and show the Dock: false"
echo -e "    › Show indicators for open applications: true"
echo -e "    › Show recent applications in Dock: false"

# Mission Control
#-------------------------------------

echo -e "\n  › System Preferences → Mission Control"

echo -e "    › Automatically rearrange Spaces based on most recent use: false"
echo -e "    › When switching to an application, switch to a Space with open windows for the application: true"
echo -e "    › Group windows by application: false"
echo -e "    › Displays have separate Spaces: true"
echo -e "    › Keyboard and Mouse Shortcuts: value"
echo -e "      › Mission Control: ^↑"
echo -e "      › Application windows: ^↓"
echo -e "      › Show Desktop: F11"

# Siri
#-------------------------------------

echo -e "\n  › System Preferences → Siri"

echo -e "    › Enable Ask Siri: false"

# Spotlight
#-------------------------------------

echo -e "\n  › System Preferences → Spotlight"

echo -e "    › List of categories"
echo -e "      › Application: true"
echo -e "      › Bookmarks & History: false"
echo -e "      › Calculator: true"
echo -e "      › Contacts: false"
echo -e "      › Conversion: true"
echo -e "      › Definition: false"
echo -e "      › Documents: true"
echo -e "      › Events & Reminders: false"
echo -e "      › Films: false"
echo -e "      › Folders: true"
echo -e "      › Fonts: false"
echo -e "      › Images: false"
echo -e "      › Mail & Messages: false"
echo -e "      › Music: false"
echo -e "      › Other: true"
echo -e "      › PDF Documents: true"
echo -e "      › Presentations: true"
echo -e "      › Spotlight Suggestions: true"
echo -e "      › Spreadsheets: true"
echo -e "      › System Preferences: true"
echo -e "    › Allow Spotlight Suggestions in Look up: true"

# Language & Region
#-------------------------------------

echo -e "\n  › System Preferences → Spotlight"

echo -e "    › List of categories"

echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"
echo -e "    › Something: value"