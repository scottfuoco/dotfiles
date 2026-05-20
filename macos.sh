#!/usr/bin/env bash
#
# macOS system preferences.
# Run on a fresh Mac: ./macos.sh
# After running, log out and back in (or restart) for all changes to take full effect.
#
set -eu

if [[ "$OSTYPE" != darwin* ]]; then
  echo "macos.sh: skipping (not on macOS)"
  exit 0
fi

echo "Applying macOS preferences..."

# Ask for sudo upfront, keep it alive in the background
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ---------------------------------------------------------------------------
# Trackpad
# ---------------------------------------------------------------------------
# Scroll direction: traditional (content moves opposite of fingers).
# `swipescrolldirection = false` means scroll direction is NOT natural.
defaults write -g com.apple.swipescrolldirection -bool false

# Tap-to-click off (physical click only)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false

# Three-finger drag off
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false

# ---------------------------------------------------------------------------
# Keyboard
# ---------------------------------------------------------------------------
# Key repeat: fastest possible (system minimum is 1)
defaults write -g KeyRepeat -int 1

# Initial repeat delay: very short (system minimum is 15)
defaults write -g InitialKeyRepeat -int 15

# Disable accent-character popup on long key press (enables uninterrupted key repeat — vim-friendly)
defaults write -g ApplePressAndHoldEnabled -bool false

# Don't auto-correct or auto-substitute (dev-friendly)
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# ---------------------------------------------------------------------------
# Screen saver
# ---------------------------------------------------------------------------
# Start screen saver after 60 minutes idle (current value on source Mac)
defaults -currentHost write com.apple.screensaver idleTime -int 3600

# ---------------------------------------------------------------------------
# Finder
# ---------------------------------------------------------------------------
defaults write com.apple.finder AppleShowAllFiles -bool true       # Show hidden files
defaults write -g AppleShowAllExtensions -bool true                # Show all file extensions
defaults write com.apple.finder ShowPathbar -bool true             # Show path bar
defaults write com.apple.finder ShowStatusBar -bool true           # Show status bar
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Search current folder by default

# ---------------------------------------------------------------------------
# Dock
# ---------------------------------------------------------------------------
defaults write com.apple.dock autohide -bool true                  # Auto-hide
defaults write com.apple.dock tilesize -int 78                     # Icon size (current value)
defaults write com.apple.dock show-recents -bool false             # Don't show recents

# ---------------------------------------------------------------------------
# Screenshots
# ---------------------------------------------------------------------------
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# ---------------------------------------------------------------------------
# Misc UX
# ---------------------------------------------------------------------------
# Expand save and print panels by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true

# Save to disk (not iCloud) by default for new docs
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ---------------------------------------------------------------------------
# Apply changes by restarting affected services
# ---------------------------------------------------------------------------
for app in "Finder" "Dock" "SystemUIServer" "cfprefsd"; do
  killall "$app" >/dev/null 2>&1 || true
done

echo ""
echo "macOS preferences applied."
echo "Some settings (key repeat, trackpad) require a logout/restart to fully take effect."
