#!/bin/bash

#-------------------------------------
#-------------------------------------

# Do not run this script as root
if [[ $EUID -eq 0 ]]; then
    clear
    echo -ne '\007'
    echo "ERROR: This script must NOT be run as root" 1>&2
    sudo -k
    exit 1
fi

# This Bash script executes several AppleScripts which target other applications like the Finder, 
# Script Editor, System Events and System Preferences. 
#Beginning with macOS Mojave, applications that control other applications need to be given explicit 
# authority the first time they request to do so. 
# As it is the Terminal application that ultimately wants to control the other applications by running AppleScripts, 
# macOS Mojave will prompt the user to grant the Terminal application authority to do so for each individual 
# application to which the response should be `OK`. 
# The Terminal application will then appear in System Preferences > Security & Privacy > Privacy > Automation 
# with a list of applications it has authority to control. 
# Authority to control an application can later be revoked on a per application basis by unchecking 
# the appropriate application in the list.

# To avoid having the user respond to prompts at different times throughout the execution of this Bash script, 
# the following AppleScripts – when run – will ensure that authority is given up-front.
osascript -e 'tell app "Finder" to display notification "Terminal has been granted access to control Finder.app" with title "Pardon My Appearance"' > /dev/null 2>&1
osascript -e 'tell app "Script Editor" to display notification "Terminal has been granted access to control Script Editor.app" with title "Pardon My Appearance"' > /dev/null 2>&1
osascript -e 'tell app "System Events" to display notification "Terminal has been granted access to control System Events.app" with title "Pardon My Appearance"' > /dev/null 2>&1
osascript -e 'tell app "System Preferences" to display notification "Terminal has been granted access to control System Preferences.app" with title "Pardon My Appearance"' > /dev/null 2>&1

# AppleScript to check if GUI Scripting is enabled. Will rightly fail for new macOS installations.
# If called by `Script Editor` then `Script Editor` must be checked in System Preferences > Security & Privacy > Privacy > Accessibility
# If called by `Terminal` (this case) then `Terminal` must be checked in System Preferences > Security & Privacy > Privacy > Accessibility
# If called by `iTerm` then `iTerm` must be checked in System Preferences > Security & Privacy > Privacy > Accessibility
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
  echo "ERROR: AppleScript has cancelled this bash script"
  exit 1
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `macos.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null 

echo 'Setting MacOS defaults...'

#-------------------------------------
# System preferences 
#-------------------------------------

echo "Configuring System Preferences..."

# General 
#-------------------------------------

echo "Configuring System Preferences - General..."

# Dark (for this mode "AppleInterfaceStyleSwitchesAutomatically" mustn't exist so delete it)
defaults write -g AppleInterfaceStyle -string Dark
defaults delete -g AppleInterfaceStyleSwitchesAutomatically 2> /dev/null # Defaults throws an error if the key does not exist, so write STDERR to /dev/null to surpress error messages

# Accent colour: Blue
defaults delete -g AppleAccentColor 2> /dev/null

# Highlight colour: Blue
defaults delete -g AppleHighlightColor 2> /dev/null 
defaults write -g AppleAquaColorVariant -int 1

# Set sidebar icon size to medium (small = 1, medium = 2, large = 3)
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Do not automatically hide and show the menu bar
defaults write -g _HIHideMenuBar -bool false

# Always show scrollbars
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Click in the scroll bar to: Jump to the next page
defaults write -g AppleScrollerPagingBehavior -bool false

# Ask keep changes when closing documents
defaults write -g NSCloseAlwaysConfirmsChanges -bool false

# Close windows when quitting an app: unchecked
defaults write -g NSQuitAlwaysKeepsWindows -bool false

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

echo "...General: done"

# Desktop & screensaver 
#-------------------------------------

echo "Configuring System Preferences - Desktop & screensaver..."

# Hot corners
# Possible values:
#    0: no-op
#    2: Mission Control
#    3: Show application windows
#    4: Desktop
#    5: Start screen saver
#    6: Disable screen saver
#    7: Dashboard
#   10: Put display to sleep
#   11: Launchpad
#   12: Notification Center
#   13: Lock Screen

# Top left screen corner → Mission Control
# defaults write com.apple.dock wvous-tl-corner -int 2
# defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
# defaults write com.apple.dock wvous-tr-corner -int 4
# defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
# defaults write com.apple.dock wvous-bl-corner -int 5
# defaults write com.apple.dock wvous-bl-modifier -int 0

# Screensaver start after 0 (= never)
defaults -currentHost write com.apple.screensaver idleTime -int 0

echo "...Desktop & screensaver: done"

# Dock 
#-------------------------------------

echo "Configuring System Preferences - Dock..."

# Set the icon size of Dock items to 16 pixels (16 = small, 128 = large)
defaults write com.apple.dock tilesize -int 16

# Magnification: unchecked
defaults write com.apple.dock magnification -bool false

# Position on screen: Bottom
defaults write com.apple.dock orientation -string "bottom"

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "genie"

# Prefer tabs when opening documents: Always
defaults write -g AppleWindowTabbingMode -string "always"

# Double-click a window's title bar to zoom: zoom
defaults write -g AppleActionOnDoubleClick -string "Maximize"

# Not minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

# Animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool true

# Do not automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Show indicators for open applications: checked
defaults write com.apple.dock show-process-indicators -bool true

# Do not show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# From left to right:
#  - Finder
#  - Google Chrome
#  - Visual Studio Code
#  - Spotify
#  - iTerm
#  - Fork
#  - WhatsApp
# dockutil --no-restart --remove all
# dockutil --no-restart --add "/Applications/Google Chrome.app"
# dockutil --no-restart --add "/Applications/Visual Studio Code.app"
# dockutil --no-restart --add "/Applications/Spotify.app"
# dockutil --no-restart --add "/Applications/iTerm.app"
# dockutil --no-restart --add "/Applications/Fork.app"
# dockutil --no-restart --add "/Applications/WhatsApp.app"

echo "...Dock: done"

# Mission control
#-------------------------------------

echo "Configuring System Preferences - Mission control..."

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

echo "...Mission control: done"

# Siri
#-------------------------------------

echo "Configuring System Preferences - Siri..."
echo "...Siri: done"

# Spotlight
#-------------------------------------

echo "Configuring System Preferences - Spotlight..."

# Hide Spotlight tray-icon (and subsequent helper)
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
# defaults write com.apple.spotlight orderedItems -array \
# 	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
# 	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
# 	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
# 	'{"enabled" = 1;"name" = "PDF";}' \
# 	'{"enabled" = 1;"name" = "FONTS";}' \
# 	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
# 	'{"enabled" = 0;"name" = "MESSAGES";}' \
# 	'{"enabled" = 0;"name" = "CONTACT";}' \
# 	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
# 	'{"enabled" = 0;"name" = "IMAGES";}' \
# 	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
# 	'{"enabled" = 0;"name" = "MUSIC";}' \
# 	'{"enabled" = 0;"name" = "MOVIES";}' \
# 	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
# 	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
# 	'{"enabled" = 0;"name" = "SOURCE";}' \
# 	'{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
# 	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
# 	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
# 	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
# 	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
# 	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Load new settings before rebuilding the index
# killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
# sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
# sudo mdutil -E / > /dev/null

echo "...Spotlight: done"

# Language & region
#-------------------------------------

echo "Configuring System Preferences - Language & region..."

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "it"
defaults write NSGlobalDomain AppleLocale -string "it@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

echo "...Language & region: done"

# Users & groups
#-------------------------------------

echo "Configuring System Preferences - Users & groups..."
echo "...Users & groups: done"

# Accessibility
#-------------------------------------

echo "Configuring System Preferences - Accessibility..."

# Use scroll gesture with the Ctrl (^) modifier key to zoom
# Could not write domain com.apple.universalaccess; exiting
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

echo "...Accessibility: done"

# Keyboard
#-------------------------------------

echo "Configuring System Preferences - Keyboard..."

# Use smart quotes and dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool true
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 5
defaults write NSGlobalDomain InitialKeyRepeat -int 9

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Do not show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool false

echo "...Keyboard: done"

# Trackpad
#-------------------------------------

echo "Configuring System Preferences - Trackpad..."

# Scroll direction: Natural
defaults write -g com.apple.swipescrolldirection -bool true

# Trackpad: enable tap to click for this user and for the login screen
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "...Trackpad: done"


# Mouse
#-------------------------------------

echo "Configuring System Preferences - Mouse..."

# Scroll direction: Natural
defaults write -g com.apple.swipescrolldirection -bool true

echo "...Mouse: done"

# Display
#-------------------------------------

echo "Configuring System Preferences - Display..."
echo "...Display: done"

# Energy saver
#-------------------------------------

echo "Configuring System Preferences - Energy saver..."

# Battery: Turn display off after: 5min (1 min [1] --> 3 hrs [180])
sudo pmset -b displaysleep 5 > /dev/null 2>&1

# Battery: Put hard disks to sleep when possible
sudo pmset -b disksleep 1 > /dev/null 2>&1

# Battery: Slightly dim the display while on battery power
sudo pmset -b lessbright 1 > /dev/null 2>&1

# Battery: Not enable Power Nap while plugged into a power adapter
sudo pmset -b powernap 0 > /dev/null 2>&1

# Power adapter: Turn display off after: 10min (1 min [1] --> 3 hrs [180])
sudo pmset -c displaysleep 10 > /dev/null 2>&1

# Power adapter: Prevent computer from sleeping automatically when the display is off: unchecked
sudo pmset -c sleep 1 > /dev/null 2>&1

# Power adapter: Put hard disks to sleep when possble: checked
sudo pmset -c disksleep 1 > /dev/null 2>&1

# Power adapter: Wake for WiFi network access: checked
sudo pmset -c womp 1 > /dev/null 2>&1

# Power adapter: Enable Power Nap while plugged into a power adapter: checked
sudo pmset -c powernap 1 > /dev/null 2>&1

echo "...Energy saver: done"

# Date & time
#-------------------------------------

echo "Configuring System Preferences - Date & time..."

# Time options: Digital
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Do not flash the time separators
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

# Thu 18 Aug 23:46:18
# Display time with seconds - Checked [:ss]
# Use a 24-hour clock - Checked [HH:mm]
# Show AM/PM - Unchecked
# Show the day of the week - Checked [EEE]
# Show date - Checked [d MMM]
defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"

echo "...Date & time: done"

#-------------------------------------
# Finder
#-------------------------------------

echo "Configuring Finder..."

# Do not show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Set Home as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Open folders in tabs instead of new windows
defaults write com.apple.finder FinderSpawnTab -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show warning before removing iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true

# Remove items from the Trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Keep folders on top on desktop
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool false

# When performing a search: Search This Mac (SCev), Search the Current Folder (SCcf), Use the Previous Search Scope (SCsp)
defaults write com.apple.finder FXDefaultSearchScope -string "SCev"

# Enable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes:
#   - Flwv = Cover Flow View
#   - Nlsv = List View
#   - clmv = Column View
#   - icnv = Icon View
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show|Hide Tab Bar: hide
defaults write com.apple.finder NSWindowTabbingShoudShowTabBarKey-com.apple.finder.TBrowserWindow -bool false	# Spelling mistake 'Shoud' instead of 'Should' courtesy of Apple!

# Show|Hide Path Bar: show
defaults write com.apple.finder ShowPathbar -bool true

# Show|Hide Status Bar: show
defaults write com.apple.finder ShowStatusBar -bool true

# Show|Hide Sidebar: show
defaults write com.apple.finder ShowSidebar -bool true

# Show|Hide Preview: hide
defaults write com.apple.finder ShowPreviewPane -bool false

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Enable spring loading for directories
# Spring loaded folders allow you to drag and drop files from one location to another, 
#  viewing what is inside the destination folder before dropping the file. 
# This is particularly useful when you want to drop a file several levels deep
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "...Finder: done"

#-------------------------------------
# Status bar
#-------------------------------------

echo "Setting Status bar..."

# Wi-Fi, Battery, Clock, Spotlight and Notifications are visible by default.  

# System Preferences > Network > Show Wi-Fi status in menu bar [checked]
open /System/Library/CoreServices/Menu\ Extras/AirPort.menu # Comment-out for unchecked
    
# System Preferences > Bluetooth > Show Bluetooth in menu bar [checked]
open /System/Library/CoreServices/Menu\ Extras/Bluetooth.menu # Comment-out for unchecked

# System Preferences > Energy Saver > Show battery status in menu bar [checked]
open /System/Library/CoreServices/Menu\ Extras/Battery.menu # Comment-out for unchecked

# System Preferences > Volume > Show volume in menu bar [checked] 
open /System/Library/CoreServices/Menu\ Extras/Volume.menu # Comment-out for unchecked

# System Preferences > Date & Time > Clock > Show date and time in menu bar [checked]
open /System/Library/CoreServices/Menu\ Extras/Clock.menu # Comment-out for unchecked

# System Preferences > Keyboard > Input Sources > Show Input menu in menu bar [checked]
# defaults write com.apple.TextInputMenu visible -bool true # Comment-out for unchecked

# System Preferences > Keyboard > Keyboard > Show keyboard and emoji viewers in menu bar [checked]
#ShowKeyboardEmojiViewer # Comment-out for unchecked

# System Preferences > Network > Show VPN status in menu bar [checked]         
# open /System/Library/CoreServices/Menu\ Extras/VPN.menu # Comment-out for unchecked

# System Preferences > Time Machine > Show Time Machine in menu bar [checked]        
# open /System/Library/CoreServices/Menu\ Extras/TimeMachine.menu # Comment-out for unchecked

echo "...Status bar: done"

#-------------------------------------
# Dock
#-------------------------------------

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
# defaults write com.apple.dock static-only -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
# defaults write com.apple.dock autohide-time-modifier -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Add a spacer to the left side of the Dock (where the applications are)
# defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
# defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

#-------------------------------------
# iTunes
#-------------------------------------

echo "Configuring iTunes..."

# Prevent iPods, iPhones and iPads from syncing automatically
defaults write com.apple.itunes dontAutomaticallySyncIPods -bool true

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

echo "...iTunes: done"

#-------------------------------------
# Hidden settings
#-------------------------------------

echo "Configuring hidden settings..."

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Enable translucent Dock icons for hidden apps
defaults write com.apple.dock showhidden -bool true

# Show full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show the ~/Library folder IMPORTANT: No longer works with High Sierra and later
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Show .hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Reopen windows when logging back in: yes
defaults write com.apple.loginwindow TALLogoutSavesState -bool true

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Enable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool false

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set highlight color to green
# How to compute RGB values:
#   1. pick your desired color
#   2. get that color’s RGB values
#   3. take each value and divide it by 255
#   4. put them into the string in order R G B.
# defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Allows text selection in the Quick Look windows
defaults write com.apple.finder QLEnableTextSelection -bool true

# Require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Remove Dropbox’s green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
# defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Reset Launchpad, but keep the desktop wallpaper intact
# find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete

echo "...Hidden settings: done"

#-------------------------------------
# Activity monitor
#-------------------------------------

echo "Configuring Activity monitor..."

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

echo "...Activity monitor: done"

#-------------------------------------
# App Store
#-------------------------------------

echo "Configuring App Store..."

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

echo "...App Store: done"

#-------------------------------------
# Safari & WebKit
#-------------------------------------

echo "Configuring Safari & WebKit..."

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

echo "...Safari & WebKit: done"

#-------------------------------------
# Google Chrome
#-------------------------------------

echo "Configuring Google Chrome..."

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
# defaults write com.google.Chrome DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

echo "...Google Chrome: done"

#-------------------------------------
# Terminal
#-------------------------------------

echo "Configuring Terminal..."

# Only use UTF-8 in Terminal.app
# defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
# defaults write com.apple.Terminal ShowLineMarks -int 0

echo "...Terminal: done"

#-------------------------------------
# iTerm 2
#-------------------------------------

echo "Configuring iTerm 2..."

# Install the Solarized Dark theme for iTerm
# open "${HOME}/init/Solarized Dark.itermcolors"

# Don’t display the annoying prompt when quitting iTerm
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

echo "...iTerm 2: done"

#-------------------------------------
# Sublime text
#-------------------------------------

echo "Configuring Sublime text..."

# Install Sublime Text settings
cp -r init/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User/Preferences.sublime-settings 2> /dev/null

echo "...Sublime text: done"

#-------------------------------------
# Kill affected applications
#-------------------------------------

echo "Killing all affected apps..."

for app in "Dock" "Finder" "Messages" "Photos"; do
  killall "${app}" &> /dev/null
done

echo "...Killing: done"

#-------------------------------------
#-------------------------------------

# Revoke sudo privileges
sudo -k

echo "Done. Note that some of these changes require a logout/restart to take effect."



