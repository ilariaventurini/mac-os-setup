#!/bin/bash

#-------------------------------------
# Backup
#-------------------------------------

current_date=`(date +%Y-%m-%d_%Hh%Mm%Ss)`

# Set variables
backup_dir=~/mac-os-setup-backup/macos/
preferences=~/Library/Preferences

# Make a backup of defaults and preferences
echo -e "\nFirst of all, I do a backup, just in case..."
echo -e "Backup folder is $backup_dir"
echo -e "  › save current defaults"
echo -e "  › copy all $preferences files"
mkdir -p $backup_dir
defaults read > $backup_dir/defaults_$current_date.json
cp -a $preferences/. $backup_dir/Preferencess_$current_date

#-------------------------------------
# Setting macOS defaults
#-------------------------------------

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

echo -e "    › Appearance: Dark"
defaults write -g AppleInterfaceStyle -string Dark
defaults delete -g AppleInterfaceStyleSwitchesAutomatically 2> /dev/null # Defaults throws an error if the key does not exist, so write STDERR to /dev/null to surpress error messages

echo -e "    › Accent colour: Blue"
defaults delete -g AppleAccentColor 2> /dev/null

echo -e "    › Highlight colour: Blue"
defaults delete -g AppleHighlightColor 2> /dev/null 
defaults write -g AppleAquaColorVariant -int 1

# Set sidebar icon size to medium (small = 1, medium = 2, large = 3)
echo -e "    › Sidebar icon size: Medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

echo -e "    › Automatically hide and show the menu bar: false"
defaults write -g _HIHideMenuBar -bool false

# Always show scrollbars: `WhenScrolling`, `Automatic` and `Always`
echo -e "    › Show scroll bars: Always"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

echo -e "    › Click in the scroll bar to: Jump to the next page"
defaults write -g AppleScrollerPagingBehavior -bool false

echo -e "    › Default web browser: Google Chrome.app"

echo -e "    › Ask keep changes when closing documents: false"
defaults write -g NSCloseAlwaysConfirmsChanges -bool false

echo -e "    › Close windows when quitting an app: false"
defaults write -g NSQuitAlwaysKeepsWindows -bool false

echo -e "    › Recent items: 10"

echo -e "    › Allow Handoff between this Mac and your iCloud devices: true"

echo -e "    › Use font smoothing when available: true"

# Desktop & Screen Saver  
#-------------------------------------

echo -e "\n  › System Preferences → Desktop & Screen Saver"

# Hot corners
#  * bl, br, tl, tr refer to the bottom-left, bottom-right, top-left and top-right corners respectively.
#  * The values for the wvous-*-corner keys represent the actions associated with each corner:
#     -  0: no-op
#     -  2: Mission Control
#     -  3: Show application windows
#     -  4: Desktop
#     -  5: Start screen saver
#     -  6: Disable screen saver
#     -  7: Dashboard
#     - 10: Put display to sleep
#     - 11: Launchpad
#     - 12: Notification Center
#     - 13: Lock Screen
#  * The values for the vwous-*-modifier keys represent combinations of modifier keys 
#    which need to be pressed for the hot corner to trigger as a bit mask: 
#     - 0: no modifier key
#     - 131072 = 2^17: Shift
#     - 262144 = 2^18: Control
#     - 524288 = 2^19: Option
#     - 1048576 = 2^20: Command

echo -e "    › Hot Corners"

echo -e "      › Top left screen corner:  Mission Control (Command)"
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tl-modifier -int 1048576

echo -e "      › Top right screen corner: Mission Control (Command)"
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-tr-modifier -int 1048576

echo -e "      › Bottom left screen corner: Mission Control (Command)"
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-bl-modifier -int 1048576

echo -e "      › Bottom right screen corner: Mission Control (Command)"
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 1048576

# Dock 
#-------------------------------------

echo -e "\n  › System Preferences → Dock"

# Set the icon size of Dock items to 16 pixels (16 = small, 128 = large)
echo -e "    › Size: Small"
defaults write com.apple.dock tilesize -int 16

echo -e "    › Magnification: false"
echo -e "      › false"
echo -e "      › Max (16 [Small] -> 128 [Max])"
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock largesize -int 128

echo -e "    › Position on screen: Bottom"
defaults write com.apple.dock orientation -string "bottom"

echo -e "    › Minimise windows using: Genie effect"
defaults write com.apple.dock mineffect -string "genie"

echo -e "    › Prefer tabs when opening docuements: Always"
defaults write -g AppleWindowTabbingMode -string "always"

echo -e "    › Double-click a window’s title bar to"
echo -e "      › true"
echo -e "      › Zoom"
defaults write -g AppleActionOnDoubleClick -string "Maximize"

echo -e "    › Minimize windows into application icon: false"
defaults write com.apple.dock minimize-to-application -bool false

echo -e "    › Animate opening applications: true"
defaults write com.apple.dock launchanim -bool true

echo -e "    › Automatically hide and show the Dock: false"
defaults write com.apple.dock autohide -bool false

echo -e "    › Show indicators for open applications: true"
defaults write com.apple.dock show-process-indicators -bool true

echo -e "    › Show recent applications in Dock: false"
defaults write com.apple.dock show-recents -bool false

# From left to right:
#  - Finder
#  - Google Chrome
#  - Visual Studio Code
#  - Spotify
#  - iTerm
#  - Fork

# Mission Control
#-------------------------------------

echo -e "\n  › System Preferences → Mission Control"

echo -e "    › Automatically rearrange Spaces based on most recent use: false"
defaults write com.apple.dock mru-spaces -bool false

echo -e "    › When switching to an application, switch to a Space with open windows for the application: true"
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true

echo -e "    › Group windows by application: false"
defaults write com.apple.dock expose-group-apps -bool false

echo -e "    › Displays have separate Spaces: true"
defaults write com.apple.spaces spans-displays -bool true

echo -e "    › Keyboard and Mouse Shortcuts"
echo -e "      › Mission Control: ^↑"
echo -e "      › Application windows: ^↓"
echo -e "      › Show Desktop: F11"


# Siri
#-------------------------------------

echo -e "\n  › System Preferences → Siri"

echo -e "    › Enable Ask Siri: false"
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

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

defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1; "name" = "APPLICATIONS";}' \
  '{"enabled" = 1; "name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
  '{"enabled" = 1; "name" = "MENU_CONVERSION";}' \
  '{"enabled" = 1; "name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0; "name" = "MENU_DEFINITION";}' \
  '{"enabled" = 1; "name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1; "name" = "DOCUMENTS";}' \
  '{"enabled" = 1; "name" = "DIRECTORIES";}' \
  '{"enabled" = 1; "name" = "PRESENTATIONS";}' \
  '{"enabled" = 1; "name" = "SPREADSHEETS";}' \
  '{"enabled" = 1; "name" = "PDF";}' \
  '{"enabled" = 0; "name" = "MESSAGES";}' \
  '{"enabled" = 0; "name" = "CONTACT";}' \
  '{"enabled" = 0; "name" = "EVENT_TODO";}' \
  '{"enabled" = 0; "name" = "IMAGES";}' \
  '{"enabled" = 0; "name" = "BOOKMARKS";}' \
  '{"enabled" = 0; "name" = "MUSIC";}' \
  '{"enabled" = 0; "name" = "MOVIES";}' \
  '{"enabled" = 0; "name" = "FONTS";}' \
  '{"enabled" = 1; "name" = "MENU_OTHER";}'

echo -e "    › Allow Spotlight Suggestions in Look up: true"

# Language & Region
#-------------------------------------

echo -e "\n  › System Preferences → Language & Region"

echo -e "    › Preferred languages"
echo -e "      › English"
echo -e "      › Italiano"
defaults write NSGlobalDomain AppleLanguages -array "en-IT" "it-IT"

echo -e "    › Region: Italy"
defaults write NSGlobalDomain AppleLocale -string "en_IT"

echo -e "    › First day of week: Monday"

echo -e "    › Calendar: Gregorian"

echo -e "    › Time format: 24-Hour Time"

echo -e "    › Temperature: °C - Celsius"
defaults write NSGlobalDomain AppleMetricUnits -string "Celsius"

echo -e "    › Advanced - General"

echo -e "      › Number separators"
echo -e "        › Grouping: ."
echo -e "        › Decimal: ,"

echo -e "      › Currency: Euro (€)"
echo -e "        › Grouping: ."
echo -e "        › Decimal: ,"

echo -e "      › Measurement units: Metric"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

echo -e "    › Advanced - Dates"
echo -e "      › Short: 01/06/2020"
echo -e "      › Medium: 1 Jun 2020"
echo -e "      › Long: 1 Jun 2020"
echo -e "      › Full: Monday, 1 Jun 2020"

echo -e "    › Advanced - Times"
echo -e "      › Short: 07:08"
echo -e "      › Medium: 07:08:09"
echo -e "      › Long: 07:08:09 CEST"
echo -e "      › Full: 07:08:09 Central European Summer Time"
echo -e "      › Before noon: AM"
echo -e "      › After noon: PM"

# Notifications
#-------------------------------------

echo -e "\n  › System Preferences → Notifications"

# Internet Accounts
#-------------------------------------

echo -e "\n  › System Preferences → Internet Accounts"

# Users & Groups
#-------------------------------------

echo -e "\n  › System Preferences → Users & Groups"

# Accessibility
#-------------------------------------

echo -e "\n  › System Preferences → Accessibility"

echo -e "    › Show Accessibility status in menu bar: false"

echo -e "    › VoiceOver: value"

echo -e "      › Enable VoiceOver: false"

echo -e "    › Zoom"

echo -e "      › Use keyboard shortcuts to zoom: false"

echo -e "      › Use scroll gesture with modifier keys to zoom"
echo -e "        › true"
echo -e "        › ^ Control"
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

echo -e "      › Zoom style: Full screen"

echo -e "      › Enable Hover Text: false"

echo -e "    › Display"

echo -e "      › Display"

echo -e "        › Invert colours: false"

echo -e "        › Reduce motion: false"

echo -e "        › Increase contrast: false"

echo -e "        › Reduce transparency: false"

echo -e "        › Differentiate without colour: false"
echo -e "        › Display contrast: normal"

echo -e "      › Cursor"

echo -e "        › Shake mouse pointer to locate: true"
defaults write CGDisableCursorLocationMagnification -bool true

echo -e "        › Cursor size: normal"
echo -e "      › Colour Filters"
echo -e "        › Enable Colour Filters: false"
echo -e "        › Filter type: Greyscale"
echo -e "    › Speech"
echo -e "      › System voicw: Alex"
echo -e "      › Speaking Rate: normal"
echo -e "      › Enable announcements: false"
echo -e "      › Speak selected text when the key is pressed: false"
echo -e "      › Speak items under the pointer: false"
echo -e "    › Descriptions"
echo -e "      › Play audio descriptions when available: false"
echo -e "    › Audio"
echo -e "      › Flash the screen when an alert sound occurs: false"
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false

echo -e "      › Play stereo audio as mono: false"
echo -e "    › Captions"
echo -e "      › Style for subtitles and captions: Transparent Background"
echo -e "      › Prefer closed captions and SDH: false"
echo -e "    › Voice Control"
echo -e "      › Enable Voice Control: value"
echo -e "      › Language: English (United Kingdom)"
echo -e "      › Microphone: Internal Microphone"
echo -e "      › Play sound when command is recognised: false"
echo -e "    › Keyboard"
echo -e "      › Hardware"
echo -e "        › Enable Sticky Keys: false"
echo -e "        › Enable Slow Keys: false"
echo -e "        › Enable Typing Feedback: false"
echo -e "      › Accessibility Keyboard"
echo -e "        › Enable Accessibility Keyboard: false"
echo -e "    › Pointer Control"
echo -e "      › Mouse & Trackpad"
echo -e "        › Double-click speed: 8"
echo -e "        › Spring-loading delay"
echo -e "          › true"
echo -e "          › 5"
echo -e "        › Ignore built-in trackpad when mouse or wireless trackpad is present: false"
echo -e "      › Alternative Control Methods"
echo -e "        › Enable Mouse Keys: false"
echo -e "        › Enable alternative pointer actions: false"
echo -e "        › Enable head pointer: false"
echo -e "    › Switch Control"
echo -e "      › General"
echo -e "        › Enable Swith Control: false"
echo -e "        › Appearance: Dark"
echo -e "        › Hide panel after inactivity: false"
echo -e "        › Allow platform switching to control your computer: false"
echo -e "      › Typing"
echo -e "        › Show current text in keyboard panel: true"
echo -e "        › Insert and remove spaces automatically: false"
echo -e "        › Capitalise sentences automatically: false"
echo -e "      › Switches"
echo -e "      › Navigation"
echo -e "        › While navigating: Do nothing"
echo -e "        › Restart position: After Cursor"
echo -e "        › Auto scanning after select: Do nothing"
echo -e "        › When pointer reaches edge: Bounce back"
echo -e "        › Switch Control cursor size: Small"
echo -e "        › Pointer precision: false"
echo -e "        › Something: Low"
echo -e "        › Loops: 2"
echo -e "    › Siri"
echo -e "      › Enable Type to Siri: false"
echo -e "    › Shortcut"
echo -e "      › Zoom: true"
echo -e "      › VoiceOver: true"
echo -e "      › Sticky Keys: true"
echo -e "      › Slow Keys: true"
echo -e "      › Mouse Keys: true"
echo -e "      › Accessibility Keyboard: true"
echo -e "      › Invert Display Colour: true"
echo -e "      › Colour Filters: true"
echo -e "      › Head Pointer: true"

# Screen Time
#-------------------------------------

echo -e "\n  › System Preferences → Screen Time"

# Extensions
#-------------------------------------

echo -e "\n  › System Preferences → Extensions"

# Security & Privacy
#-------------------------------------

echo -e "\n  › System Preferences → Security & Privacy"

# Software Update
#-------------------------------------

echo -e "\n  › System Preferences → Software Update"

# Network
#-------------------------------------

echo -e "\n  › System Preferences → Network"

# Bluetooth
#-------------------------------------

echo -e "\n  › System Preferences → Bluetooth"

# Sound
#-------------------------------------

echo -e "\n  › System Preferences → Sound"

# Printers & Scanners
#-------------------------------------

echo -e "\n  › System Preferences → Printers & Scanners"

# Keyboard
#-------------------------------------

echo -e "\n  › System Preferences → Keyboard"

echo -e "    › Show Input menu in menu bar: false"

echo -e "    › Keyboard"
echo -e "      › Key Repeat: 6/7"
echo -e "      › Delay Until Repeat: 2/5"
echo -e "      › Adjust keyboard brightness in low light: true"
echo -e "      › Turn keyboard backlight off after 5secs of inactivity"
echo -e "      › Show keyboard and emoji viewers in menu bar: false"
echo -e "      › Use F1, F2, etc. keys as standard function keys: false"

echo -e "    › Text"
echo -e "      › Correct spelling automatically: true"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

echo -e "      › Capitalise words automatically: true"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true

echo -e "      › Add full stop with double-space: true"
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true

echo -e "      › Spelling: Automatic by Language"
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool true

echo -e "      › Use smart quotes and dashes: true"
echo -e "        › for Double Quotes: \"abc\""
echo -e "        › for Single Quotes: 'abc'"
defaults write -g NSAutomaticDashSubstitutionEnabled -bool true
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool true

echo -e "    › Shortcuts"
echo -e "      › Use keyboard navigation to move focus between controls: false"
echo -e "      › Launchpad & Dock"
echo -e "        › Turn Dock Hiding On/Off"
echo -e "          › true"
echo -e "          › ⌥⌘D"
echo -e "        › Show Launchpad"
echo -e "          › false"
echo -e "          › none"
echo -e "      › Misssion Control"
echo -e "        › Mission Control"
echo -e "          › true"
echo -e "          › ^↑"
echo -e "        › Show Notification Centre"
echo -e "          › false"
echo -e "          › none"
echo -e "        › Turn Do Not Disturb On/Off"
echo -e "          › true"
echo -e "          › none"
echo -e "        › Application windows"
echo -e "          › true"
echo -e "          › ^↓"
echo -e "        › Show Desktop"
echo -e "          › true"
echo -e "          › F11"
echo -e "        › Mission Control: true"
echo -e "          › Move left a space"
echo -e "            › true"
echo -e "            › ^←"
echo -e "          › Move right a space"
echo -e "            › true"
echo -e "            › ^→"
echo -e "          › Switch to Desktop 1"
echo -e "            › false"
echo -e "            › ^1"
echo -e "          › Switch to Desktop 2"
echo -e "            › false"
echo -e "            › ^2"
echo -e "          › Switch to Desktop 3"
echo -e "            › false"
echo -e "            › ^3"
echo -e "          › Switch to Desktop 4"
echo -e "            › false"
echo -e "            › ^4"
echo -e "          › Switch to Desktop 5"
echo -e "            › false"
echo -e "            › ^5"
echo -e "          › Switch to Desktop 6"
echo -e "            › false"
echo -e "            › ^6"
echo -e "          › Switch to Desktop 7"
echo -e "            › false"
echo -e "            › ^7"
echo -e "          › Switch to Desktop 8"
echo -e "            › false"
echo -e "            › ^8"
echo -e "      › Keyboard"
echo -e "        › Change the way Tab moves focus"
echo -e "          › true"
echo -e "          › ^F7"
echo -e "        › Turn keyboard access on or off"
echo -e "          › true"
echo -e "          › ^F1"
echo -e "        › Move focus to the menu bar"
echo -e "          › true"
echo -e "          › ^F2"
echo -e "        › Move focus to the dock"
echo -e "          › true"
echo -e "          › ^F3"
echo -e "        › Move focus to active or next window"
echo -e "          › true"
echo -e "          › ^F4"
echo -e "        › Move focus to the window toolbar"
echo -e "          › true"
echo -e "          › ^F5"
echo -e "        › Move focus to the floating window"
echo -e "          › true"
echo -e "          › ^F6"
echo -e "        › Move focus to next window"
echo -e "          › true"
echo -e "          › ⌘"
echo -e "        › Move focus to the window drawer"
echo -e "          › true"
echo -e "          › ⌥⌘"
echo -e "        › Move focus to the status menus"
echo -e "          › true"
echo -e "          › ^F8"
echo -e "      › Screenshots"
echo -e "        › Save picture of screen as a file"
echo -e "          › true"
echo -e "          › ⇧⌘3"
echo -e "        › Copy picture of screen to the clipboard"
echo -e "          › true"
echo -e "          › ^⇧⌘3"
echo -e "        › Save picture of selected area as a file"
echo -e "          › true"
echo -e "          › ⇧⌘4"
echo -e "        › Copy picture of selected area to the clipdoard"
echo -e "          › true"
echo -e "          › ^⇧⌘4"
echo -e "        › Screenshot and recording options"
echo -e "          › true"
echo -e "          › ⇧⌘5"
echo -e "      › Services"
echo -e "        › Pictures: true"
echo -e "          › Import Image"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Set Desktop Picture"
echo -e "            › true"
echo -e "            › none"
echo -e "        › Messaging: true"
echo -e "          › New Email To Address"
echo -e "            › true"
echo -e "            › none"
echo -e "          › New Email With Selection"
echo -e "            › true"
echo -e "            › none"
echo -e "        › Development: false"
echo -e "        › Files and Folders: true"
echo -e "          › Open Selected File in TextEdit"
echo -e "            › false"
echo -e "            › none"
echo -e "          › New Terminal at Folder"
echo -e "            › true"
echo -e "            › none"
echo -e "          ›  New Terminal Tab at Folder"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Encode Selected Audio Files"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Encode Selected Video Files"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Folder Actions Setup..."
echo -e "            › true"
echo -e "            › none"
echo -e "          › New iTerm2 Tab Here"
echo -e "            › true"
echo -e "            › none"
echo -e "          › New iTerm2 Windows Here"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Send File To Bluetooth Device"
echo -e "            › false"
echo -e "            › ⇧⌘B"
echo -e "        › Searching: true"
echo -e "          › Look Up in Dictionary"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Search wit Google"
echo -e "            › true"
echo -e "            › ⇧⌘L"
echo -e "          › Spotlight"
echo -e "            › false"
echo -e "            › ⇧⌘F"
echo -e "        › Text: true"
echo -e "          › Add to Music as a Spoken Track"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Convert Text to Full Width"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Convert Text to Half Width"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Convert Text to Simplified Chinese"
echo -e "            › true"
echo -e "            › ^⌥⇧⌘C"
echo -e "          › Convert Text to Traditional Chinese"
echo -e "            › true"
echo -e "            › ^⇧⌘C"
echo -e "          › Create Collection From Text"
echo -e "            › false"
echo -e "            › none"
echo -e "          › Create Font Library From Text"
echo -e "            › false"
echo -e "            › none"
echo -e "          › Display Font Information"
echo -e "            › false"
echo -e "            › none"
echo -e "          › Make New Sticky Note"
echo -e "            › true"
echo -e "            › ⇧⌘Y"
echo -e "          › New Text Edit Window containing Selection"
echo -e "            › false"
echo -e "            › none"
echo -e "          › Open"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Show in Finder"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Show into in Finder"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Open man Page in Terminal"
echo -e "            › true"
echo -e "            › ⇧⌘M"
echo -e "          › Search man Page Index in Terminal"
echo -e "            › true"
echo -e "            › ⇧⌘A"
echo -e "          › Show Map"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Summarize"
echo -e "            › false"
echo -e "            › none"
echo -e "        › Internet: true"
echo -e "          › Add to Reading List"
echo -e "            › true"
echo -e "            › none"
echo -e "          › Open URL"
echo -e "            › true"
echo -e "            › none"
echo -e "        › General: false"
echo -e "          › Unarchive to Current Folder"
echo -e "            › false"
echo -e "            › none"
echo -e "          › Unarchive to Desktop"
echo -e "            › false"
echo -e "            › none"
echo -e "          › Unarchive to..."
echo -e "            › false"
echo -e "            › none"
echo -e "      › Spotlight"
echo -e "        › Show Spotlight search"
echo -e "          › true"
echo -e "          › ⌘Space"
echo -e "        › Show Finder search window"
echo -e "          › false"
echo -e "          › ⌥⌘Space"
echo -e "      › Accessibility"
echo -e "        › Zoom: false"
echo -e "          › Turn zoom on or off"
echo -e "            › false"
echo -e "            › ⌥⌘B"
echo -e "          › Turn image smoothing on or off"
echo -e "            › false"
echo -e "            › ⌥⌘\\"
echo -e "          › Zoom out"
echo -e "            › false"
echo -e "            › ⌥⌘-"
echo -e "          › Zoom in"
echo -e "            › false"
echo -e "            › ⌥⌘="
echo -e "          › Turn focus following on or off"
echo -e "            › false"
echo -e "            › none"
echo -e "        › Contrast: false"
echo -e "          › Increase contrast"
echo -e "            › true"
echo -e "            › ^⌥⌘."
echo -e "          › Decrease contrast"
echo -e "            › true"
echo -e "            › ^⌥⌘,"
echo -e "        › Invert colours"
echo -e "          › false"
echo -e "          › ^⌥⌘8"
echo -e "        › Turn VoiceOver on or off"
echo -e "          › true"
echo -e "          › ⌘F5"
echo -e "        › Show Accessibility controls"
echo -e "          › true"
echo -e "          › ⌥⌘F5"
echo -e "      › App Shortcuts"
echo -e "        › Show Help menu"
echo -e "          › true"
echo -e "          › ⇧⌘/"
echo -e "    › Input Sources"
echo -e "      › Italian"
echo -e "    › Dictation"
echo -e "      › Dictation: Off"
echo -e "      › Language: English (United Kingdom)"
echo -e "      › Shortcut: Press Fn (Function) Key Twice"

# Trackpad
#-------------------------------------

echo -e "\n  › System Preferences → Trackpad"

echo -e "    › Point & Click"

echo -e "      › Look up & data detectors"
echo -e "        › true"
echo -e "        › Force Click with one finger"
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

echo -e "      › Secondary click"
echo -e "        › true"
echo -e "        › Click with two fingers"

echo -e "      › Tap to click: false"

echo -e "      › Click: Medium"

echo -e "      › Tracking speed: Fast"
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3

echo -e "      › Force Click and haptic feedback: true"
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

echo -e "    › Scroll & Zoom"

echo -e "      › Scroll direction: Natural"
defaults write -g com.apple.swipescrolldirection -bool true

echo -e "      › Zoom in or out: true"

echo -e "      › Smart zoom: true"

echo -e "      › Rotate: true"

echo -e "    › More Gestures"

echo -e "      › Swipe between pages"
echo -e "        › false"
echo -e "        › Scroll left or right with two fingers"
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

echo -e "      › Swipe between full-screen apps"
echo -e "        › true"
echo -e "        › Swipe left or right with three fingers"

echo -e "      › Notification Centre"
echo -e "        › true"
echo -e "        › Swipe left from the right edge with two fingers"

echo -e "      › Mission Control"
echo -e "        › true"
echo -e "        › Swipe up with three fingers"

echo -e "      › App Exposé"
echo -e "        › false"
echo -e "        › Swipe down with three fingers"

echo -e "      › Launchpad: true"

echo -e "      › Show Desktop: true"

# Mouse
#-------------------------------------

echo -e "\n  › System Preferences → Mouse"

# Displays
#-------------------------------------

echo -e "\n  › System Preferences → Displays"

echo -e "    › Display"
echo -e "      › Resolution: Default for display"
echo -e "      › Brightness: 20"
echo -e "      › Automatically adjust brightness: false"
echo -e "    › Colour"
echo -e "    › Night Shift"
echo -e "      › Schedule: Custom"
echo -e "      › From 00:00 to 23:59"
echo -e "      › Manual: true - Turn on until later today"
echo -e "      › Colour temperature: 90/100"
echo -e "    › AirPlay Display: Off"

echo -e "    › Show mirroring options in the menu bar when available: true"
defaults write com.apple.airplay showInMenuBarIfPresent -bool true

# Sidecar
#-------------------------------------

echo -e "\n  › System Preferences → Sidecar"

echo -e "    › Show Sidebar: on the left"
echo -e "    › Show Touch bar: on the bottom"
echo -e "    › Enable double tap on Apple Pencil: false"

# Energy Saver
#-------------------------------------

echo -e "\n  › System Preferences → Energy Saver"

echo -e "    › Battery"

echo -e "      › Turn display off after: 15 min"
sudo pmset -b displaysleep 15 > /dev/null 2>&1

echo -e "      › Put hard disks to sleep when possible: true"
sudo pmset -b disksleep 1 > /dev/null 2>&1

echo -e "      › Slightly dim the display while on battery power: true"
sudo pmset -b lessbright 1 > /dev/null 2>&1

echo -e "      › Enable Power Nap while on battery power: false"
sudo pmset -b powernap 0 > /dev/null 2>&1

echo -e "    › Power Adapter"

echo -e "      › Turn display off after: 15 min"
sudo pmset -c displaysleep 15 > /dev/null 2>&1

echo -e "      › Prevent computer from sleeping automatically when the display is off: true"
sudo pmset -c sleep 0 > /dev/null 2>&1

echo -e "      › Put hard disks to sleep when possible: true"
sudo pmset -c disksleep 1 > /dev/null 2>&1

echo -e "      › Wake for Wi-Fi network access: true"
sudo pmset -c womp 1 > /dev/null 2>&1

echo -e "      › Enable Power Nap while plugged into a power adapter: false"
sudo pmset -c powernap 0 > /dev/null 2>&1

echo -e "    › Show battery status in menu bar: true"

# Date & Time
#-------------------------------------

echo -e "\n  › System Preferences → Date & Time"

echo -e "    › Date & Time"
echo -e "      › Set date and time automatically"
echo -e "        › true"
echo -e "        › Apple America/US (time.apple.com)"
echo -e "    › Time Zone"
echo -e "      › Set time zone automatically using current location: true"
echo -e "    › Clock"
echo -e "      › Show date and time in menu bar: true"
echo -e "      › Time options"
echo -e "        › Digital"
echo -e "        › Display the time with seconds: true"
echo -e "        › Flash the time separators: false"
echo -e "        › Use a 24-hour clock: true"
echo -e "        › Show am/pm: false"
echo -e "      › Date options"
echo -e "        › Show the day of the week: true"
echo -e "        › Show date: true"
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss" # Thu 18 Aug 23:46:18
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

echo -e "      › Announce the time: false"

# Sharing
#-------------------------------------

echo -e "\n  › System Preferences → Sharing"

# Time Machine
#-------------------------------------

echo -e "\n  › System Preferences → Time Machine"

echo -e "    › Backup automatically: false"
echo -e "    › Show Time Machine in menu bar: false"

# Startup Disk
#-------------------------------------

echo -e "\n  › System Preferences → Startup Disk"

# Profiles
#-------------------------------------

echo -e "\n  › System Preferences → Profiles"

#-------------------------------------
# Finder
#-------------------------------------

echo -e "\n› Configuring Finder"

# General
#-------------------------------------

echo -e "\n  › Finder → General"

echo -e "    › Show these items on the desktop"
echo -e "      › Hard disks: false"
echo -e "      › External disks: false"
echo -e "      › CDs, DVDs and iPods: false"
echo -e "      › Connected servers: false"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

echo -e "    › New Finder windows show: ilariaventurini ($HOME)"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo -e "    › Open folders in tabs instead of new windows: true"
defaults write com.apple.finder FinderSpawnTab -bool true

# Tags
#-------------------------------------

echo -e "\n  › Finder → Tags"

# Sidebar
#-------------------------------------

echo -e "\n  › Finder → Sidebar"

echo -e "    › Show these items in the sidebar"
echo -e "      › Favourites"
echo -e "        › Recents: true"
echo -e "        › AirDrop: false"
echo -e "        › Applications: true"
echo -e "        › Desktop: true"
echo -e "        › Documents: true"
echo -e "        › Downloads: true"
echo -e "        › Movies: false"
echo -e "        › Music: false"
echo -e "        › Pictures: false"
echo -e "        › ilariaventurini: true"
echo -e "      › iCloud"
echo -e "        › iCloud Drive: true"
echo -e "      › Locations"
echo -e "        › Ilaria's Mackbook pro: false"
echo -e "        › Hard disks: true"
echo -e "        › External disks: true"
echo -e "        › CDs, DVDs and iOS devices: true"
echo -e "        › Bonjour computers: true"
echo -e "        › Connected servers: true"
echo -e "      › Tags"
echo -e "        › Recents tags: true"

# Advanced
#-------------------------------------

echo -e "\n  › Finder → Advanced"

echo -e "    › Show all filename extensions: true"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo -e "    › Show warning before changing an extension: true"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true

echo -e "    › Show warning before removing from iCloud drive: true"
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true

echo -e "    › Show warning before emptyng the Bin: true"
defaults write com.apple.finder WarnOnEmptyTrash -bool true

echo -e "    › Remove items from the Bin after 30 days: false"
defaults write com.apple.finder FXRemoveOldTrashItems -bool false

echo -e "    › Keep folders on top:"
echo -e "      › In windows when sorting by name: true"
echo -e "      › On Desktop: false"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool false

echo -e "    › When performing a search: Search in this Mac"
defaults write com.apple.finder FXDefaultSearchScope -string "SCev"

# Other
#-------------------------------------

echo -e "\n  › Other"

# Spring loading for directories
# Spring loaded folders allow you to drag and drop files from one location to another, 
# viewing what is inside the destination folder before dropping the file. 
# This is particularly useful when you want to drop a file several levels deep
echo -e "    › Spring loading for directories"
echo -e "      › Enable: true"
echo -e "      › Delay: 0.5"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

echo -e "    › Show all filename extensions: true"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes:
#   - Flwv = Cover Flow View
#   - Nlsv = List View
#   - clmv = Column View
#   - icnv = Icon View
echo -e "    › Finder default view mode: List View"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

echo -e "    › Show path bar: true"
defaults write com.apple.finder ShowPathbar -bool true

echo -e "    › Show status bar: true"
defaults write com.apple.finder ShowStatusBar -bool true

echo -e "    › Show side bar: true"
defaults write com.apple.finder ShowSidebar -bool true

echo -e "    › Show preview bar: false"
defaults write com.apple.finder ShowPreviewPane -bool false

echo -e "    › Show . hidden files: true"
defaults write com.apple.finder AppleShowAllFiles -bool true

#-------------------------------------
# Miscellaneous
#-------------------------------------

echo -e "\n› Miscellaneous"

echo -e "  › Reopen windows when logging back in: true"
defaults write com.apple.loginwindow TALLogoutSavesState -bool true

echo -e "  › Show the ~/Library folder: true"
chflags nohidden ~/Library

echo -e "  › iTunes"
echo -e "    › Prevent iPods, iPhones and iPads from syncing automatically: true"
defaults write com.apple.itunes dontAutomaticallySyncIPods -bool true

echo -e "  › Activity Monitor"
echo -e "    › Show the main window when launching Activity Monitor: true"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
echo -e "    › Show N processes in Activity Monitor: 100"
defaults write com.apple.ActivityMonitor ShowCategory -int 100

echo -e "  › Google Chrome"
echo -e "    › Expand the print dialog by default: true"
defaults write com.apple.loginwindow TALLogoutSavesState -bool true

echo -e "  › Terminal"
echo -e "    › Enable Secure Keyboard Entry in Terminal.app: false"
defaults write com.apple.terminal SecureKeyboardEntry -bool false

echo -e "  › iTerm2"
echo -e "    › Display the annoying prompt when quitting iTerm: true"
defaults write com.googlecode.iterm2 PromptOnQuit -bool true

echo -e "  › Safari"
echo -e "    › Auto-correct: true"
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool true

#-------------------------------------
# Kill affected applications
#-------------------------------------

echo -e "\nDone!"

echo -e "\nKilling some open applications in order to take effect..."
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" "Terminal" "Transmission"; do
  killall "${app}" > /dev/null 2>&1
done

echo -e "Revoke sudo privileges..."
sudo -k

echo -e "\nNote that some of these changes require a logout/restart to take effect. Bye bye :)"