# Homebrew bundle for fresh macOS setup
# Install with: brew bundle --file=Brewfile

# ---------------------------------------------------------------------------
# Taps
# ---------------------------------------------------------------------------
# NOTE: homebrew/bundle is now built into Homebrew core (no tap needed),
#       and homebrew/cask-fonts was merged into the main cask repo.
#       Both taps were deprecated/emptied, so they are removed here.
tap "aws/tap"
tap "jesseduffield/lazygit"
tap "mobile-dev-inc/tap"
tap "raine/workmux"
tap "stripe/stripe-cli"

# ---------------------------------------------------------------------------
# Languages & runtimes
# ---------------------------------------------------------------------------
brew "go"
brew "node"
brew "yarn"
brew "fnm"
brew "pyenv"
brew "pipx"
brew "ruby"
brew "openjdk"
brew "zig"
brew "zls"

# ---------------------------------------------------------------------------
# Shell & dev essentials
# ---------------------------------------------------------------------------
brew "bash"
brew "zsh"
brew "starship"
brew "tmux"
brew "neovim"
brew "stow"
brew "fzf"
brew "ripgrep"
brew "bat"
brew "eza"
brew "fd"
brew "dust"
brew "zoxide"
brew "jq"
brew "yq"
brew "sd"
brew "tree"
brew "btop"
brew "lazygit"
brew "yazi"
brew "shellcheck"
brew "watchman"
brew "wget"
brew "curl"
brew "whois"
brew "mkcert"
brew "openssh"
brew "tree-sitter"

# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------
brew "git"
brew "git-lfs"
brew "git-filter-repo"
brew "git-delta"
brew "gh"
brew "commitizen"
brew "transcrypt"

# ---------------------------------------------------------------------------
# Cloud & infra
# ---------------------------------------------------------------------------
brew "awscli"
brew "cloudflared"
brew "stripe/stripe-cli/stripe"
brew "tailscale"   # CLI/daemon formula (the GUI app is the cask below)


# ---------------------------------------------------------------------------
# Media essentials
# ---------------------------------------------------------------------------
brew "ffmpeg"
brew "imagemagick"

# ---------------------------------------------------------------------------
# Mobile / React Native
# ---------------------------------------------------------------------------
brew "cocoapods"
brew "maestro"

# ---------------------------------------------------------------------------
# Misc dev
# ---------------------------------------------------------------------------
brew "opencode"
brew "rtk"
brew "workmux"

# ===========================================================================
# macOS-only entries
# ---------------------------------------------------------------------------
# Casks (GUI apps) and Mac App Store installs only work on macOS. Guarding
# them with `if OS.mac?` means `brew bundle` on Linux simply skips them
# instead of erroring out on every cask. Brewfiles are evaluated as Ruby, so
# `OS.mac?` / `OS.linux?` are available here.
# ===========================================================================
if OS.mac?
  # -------------------------------------------------------------------------
  # Taps (macOS-only casks)
  # -------------------------------------------------------------------------
  tap "manaflow-ai/cmux"        # source for the cmux terminal cask below

  # -------------------------------------------------------------------------
  # Casks — browsers
  # -------------------------------------------------------------------------
  cask "google-chrome"
  cask "arc"

  # -------------------------------------------------------------------------
  # Casks — terminals
  # -------------------------------------------------------------------------
  cask "ghostty"
  cask "iterm2"
  cask "manaflow-ai/cmux/cmux"  # native macOS terminal for AI coding agents

  # -------------------------------------------------------------------------
  # Casks — editors / IDEs
  # -------------------------------------------------------------------------
  cask "visual-studio-code"
  cask "cursor"
  cask "claude"

  # -------------------------------------------------------------------------
  # Casks — dev tools
  # -------------------------------------------------------------------------
  cask "docker-desktop"          # was: docker
  cask "tableplus"
  cask "postman"
  cask "bruno"
  cask "react-native-debugger"
  cask "android-platform-tools"
  cask "gcloud-cli"              # was: google-cloud-sdk
  cask "zulu@17"

  # -------------------------------------------------------------------------
  # Casks — productivity
  # -------------------------------------------------------------------------
  cask "raycast"
  cask "rectangle"
  cask "bettertouchtool"
  cask "obsidian"
  cask "1password"
  cask "bitwarden"
  cask "the-unarchiver"

  # -------------------------------------------------------------------------
  # Casks — communication
  # -------------------------------------------------------------------------
  cask "slack"
  cask "discord"
  cask "microsoft-teams"
  cask "whatsapp"
  cask "zoom"
  cask "loom"

  # -------------------------------------------------------------------------
  # Casks — media
  # -------------------------------------------------------------------------
  cask "spotify"

  # -------------------------------------------------------------------------
  # Casks — networking / remote
  # -------------------------------------------------------------------------
  cask "tailscale-app"          # was: tailscale

  # -------------------------------------------------------------------------
  # Casks — hardware
  # -------------------------------------------------------------------------
  cask "logi-options+"          # was: logi-options-plus
  cask "synology-drive"

  # -------------------------------------------------------------------------
  # Casks — voice / AI
  # -------------------------------------------------------------------------
  cask "wispr-flow"

  # -------------------------------------------------------------------------
  # Fonts
  # -------------------------------------------------------------------------
  cask "font-jetbrains-mono"
  cask "font-jetbrains-mono-nerd-font"
  cask "font-meslo-lg-nerd-font"
  cask "font-hack-nerd-font"

  # -------------------------------------------------------------------------
  # Mac App Store (sign in to App Store before running `brew bundle`)
  # -------------------------------------------------------------------------
  brew "mas"
  mas "Xcode", id: 497799835

  # NOTE: `mas` can only install apps already in the signed-in Apple ID's
  #       purchase history. Keynote/Numbers/Pages failed with "No apps found
  #       in the App Store for ADAM ID ..." because they aren't yet associated
  #       with this account. To use these lines: open the App Store, sign in,
  #       click "Get" once on each app, then uncomment below and re-run.
  # mas "Keynote", id: 409183694
  # mas "Numbers", id: 409203825
  # mas "Pages",   id: 409201541
end
