#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" && . "./helpers.sh"

log ""
log "###############################################" $red
log "#        DO NOT RUN THIS SCRIPT BLINDLY       #" $red
log "#         YOU'LL PROBABLY REGRET IT...        #" $red
log "#                                             #" $red
log "#              READ IT THOROUGHLY             #" $red
log "#         AND EDIT TO SUIT YOUR NEEDS         #" $red
log "###############################################" $red
log ""

ask_for_confirmation "Have you read through the script you're about to run ?"
if ! answer_for_confirmation ; then
    log_exit "1" "Read the entire script before re-launch the script"
fi
ask_for_confirmation "Did you understand that it will make changes to your computer ?"
if ! answer_for_confirmation ; then
    log_exit "1" "Read the entire script before re-launch the script"
fi
ask_for_sudo
# log_header "Command Line Tools"

# xcode-select --install &> /dev/null
# log_exit "$?" "Install Xcode Command Line Tools"

# sudo xcode-select -switch "/Library/Developer/CommandLineTools" &> /dev/null
# log_exit "$?" "Switch to /Library/Developer/CommandLineTools"

log_header "Homebrew"

if ! command -v "brew" ; then
    printf "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" &> /dev/null
    #  └─ simulate the ENTER keypress
    log_exit $? "Homebrew"
else
    log_warn "Homebrew already installed"
    log_empty_line
fi

brew tap Homebrew/bundle

brew bundle --file homebrew/Brewfile

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on &> /dev/null

# go into computer sleep mode after 20min
sudo systemsetup -setcomputersleep 20 &> /dev/null

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Finder: show hidden files by default
defaults write com.apple.Finder AppleShowAllFiles -bool false # Default

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Open the home folder in a new finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false # Default

# Disable Creation of Metadata Files on Network Volumes
# Avoids creation of .DS_Store and AppleDouble files.
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Creation of Metadata Files on USB Volumes
# Avoids creation of .DS_Store and AppleDouble files.
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Set the icon size of Dock items to 56 pixels
defaults write com.apple.dock tilesize -int 48

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

## Obsolete since macOS 10.14 (Mojave).
# Create recent items stack
# defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'

## Set hotcorner actions.  Disable "Disable Screen Saver" when found.
## The following are the values of each option in the GUI
# None = 1
#   Modifier = 1048576
# Mission Control = 2
#   Modifier = 0
# Application Windows = 3
#   Modifier = 0
# Desktop = 4
#   Modifier = 0
# Start Screen Saver = 5
#   Modifier = 0
# Disable Screen Saver = 6
#   Modifier = 0
# Dashboard = 7
#   Modifier = 0
# Put Display to Sleep = 10
#   Modifier = 0
# Launchpad = 11
#   Modifier = 0
# Notification Center = 12
#   Modifier = 0
##

# Top left screen corner → Desktop
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → no-op
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → no-op
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-bl-modifier -int 1048576

# Bottom right screen corner → no-op
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 1048576

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Enable automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Install System data files and security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Prompt user for removal of active transfers only when downloading
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

# Prompt user for quit with active transfers only when downloading
defaults write org.m0k.transmission CheckQuitDownloading -bool true

# Use `~/Downloads/torrents` to store completed downloads
defaults write org.m0k.transmission DownloadLocationConstant -bool true
defaults write org.m0k.transmission DownloadFolder -string "${HOME}/Movies"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

# Restart all aplications to apply these changes
killall "Photos" &> /dev/null
killall "Finder" &> /dev/null
killall "Dock" &> /dev/null
killall "App Store" &> /dev/null
killall "Transmission" &> /dev/null
