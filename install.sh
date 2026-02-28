#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGINS_DIR="$HOME/.zsh/plugins"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

# ---------------------------------------------------------------------------
# Detect OS
# ---------------------------------------------------------------------------
OS="unknown"
if [[ "$OSTYPE" == darwin* ]]; then
  OS="macos"
elif [[ "$OSTYPE" == linux* ]]; then
  OS="linux"
else
  error "Unsupported OS: $OSTYPE"
fi
info "Detected OS: $OS"

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
  if [[ "$OS" == "macos" ]]; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    error "Homebrew (linuxbrew) not found. Install it first: https://brew.sh"
  fi
fi
success "Homebrew available"

# Ensure brew is on PATH for this script
eval "$(brew shellenv 2>/dev/null || true)"

# ---------------------------------------------------------------------------
# Brew packages
# ---------------------------------------------------------------------------
PACKAGES=(zsh starship fzf eza bat fd ripgrep zoxide git-delta btop dust tmux gh)

info "Installing brew packages..."
for pkg in "${PACKAGES[@]}"; do
  if brew list "$pkg" &>/dev/null; then
    success "$pkg already installed"
  else
    info "Installing $pkg..."
    brew install "$pkg"
    success "$pkg installed"
  fi
done

# ---------------------------------------------------------------------------
# Zsh plugins (git clone, no plugin manager)
# ---------------------------------------------------------------------------
mkdir -p "$PLUGINS_DIR"

declare -A ZSH_PLUGINS=(
  [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
  [zsh-history-substring-search]="https://github.com/zsh-users/zsh-history-substring-search.git"
  [fast-syntax-highlighting]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
)

info "Setting up zsh plugins..."
for plugin in "${!ZSH_PLUGINS[@]}"; do
  dest="$PLUGINS_DIR/$plugin"
  if [[ -d "$dest" ]]; then
    success "$plugin already cloned"
  else
    info "Cloning $plugin..."
    git clone --depth 1 "${ZSH_PLUGINS[$plugin]}" "$dest"
    success "$plugin cloned"
  fi
done

# ---------------------------------------------------------------------------
# TPM (Tmux Plugin Manager)
# ---------------------------------------------------------------------------
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
  success "TPM already installed"
else
  info "Cloning TPM..."
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
  success "TPM installed"
fi

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------
link_file() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"

  if [[ -L "$dst" ]]; then
    rm "$dst"
  elif [[ -f "$dst" ]]; then
    warn "Backing up existing $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi

  ln -s "$src" "$dst"
  success "Linked $dst → $src"
}

info "Creating symlinks..."
link_file "$DOTFILES_DIR/zsh/.zshrc"            "$HOME/.zshrc"
link_file "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
link_file "$DOTFILES_DIR/tmux/.tmux.conf"        "$HOME/.config/tmux/tmux.conf"
link_file "$DOTFILES_DIR/tmux/tmux.reset.conf"   "$HOME/.config/tmux/tmux.reset.conf"
link_file "$DOTFILES_DIR/git/.gitconfig-delta"   "$HOME/.gitconfig-delta"

# ---------------------------------------------------------------------------
# Set zsh as default shell
# ---------------------------------------------------------------------------
ZSH_PATH="$(command -v zsh)"
CURRENT_SHELL="$(basename "$SHELL")"

if [[ "$CURRENT_SHELL" != "zsh" ]]; then
  info "Setting zsh as default shell..."
  # Ensure zsh is in /etc/shells
  if ! grep -qx "$ZSH_PATH" /etc/shells 2>/dev/null; then
    warn "Adding $ZSH_PATH to /etc/shells (needs sudo)"
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
  fi
  chsh -s "$ZSH_PATH"
  success "Default shell set to zsh"
else
  success "zsh is already the default shell"
fi

# ---------------------------------------------------------------------------
# fzf key bindings setup
# ---------------------------------------------------------------------------
if [[ -f "$(brew --prefix)/opt/fzf/install" ]]; then
  info "Setting up fzf key bindings..."
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
  success "fzf key bindings configured"
fi

# ---------------------------------------------------------------------------
# Git delta integration hint
# ---------------------------------------------------------------------------
if ! git config --global --get include.path | grep -q ".gitconfig-delta" 2>/dev/null; then
  warn "Add delta to your git config by running:"
  echo "  git config --global include.path ~/.gitconfig-delta"
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Dotfiles installation complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "  Installed: ${PACKAGES[*]}"
echo "  Plugins:   ${!ZSH_PLUGINS[*]}"
echo "  TPM:       $TPM_DIR"
echo ""
echo "  Next steps:"
echo "    1. Log out and back in (or run: exec zsh)"
echo "    2. In tmux, press Ctrl+A then I to install tmux plugins"
echo "    3. Run: git config --global include.path ~/.gitconfig-delta"
echo ""
