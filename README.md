# Dotfiles

Portable dev environment for macOS and Linux.

## Quick Start

```bash
git clone <repo-url> ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
# Log out and back in (or: exec zsh)
```

Then in tmux, press `Ctrl+A, I` to install tmux plugins.

## What's Included

| Tool | Purpose |
|------|---------|
| **zsh** | Shell (3 plugins, no manager) |
| **starship** | Minimal prompt |
| **fzf** | Ctrl+R fuzzy history search |
| **eza** | Modern `ls` with icons |
| **bat** | Modern `cat` with syntax highlighting |
| **fd** | Modern `find` |
| **ripgrep** | Modern `grep` |
| **zoxide** | Smart `cd` |
| **delta** | Better git diffs |
| **btop** | Modern `top` |
| **dust** | Modern `du` |
| **tmux** | Terminal multiplexer |

## Aliases

All modern tools shadow their originals. Access originals with a backslash:

```
ls  → eza          \ls  → original ls
cat → bat          \cat → original cat
grep → rg          \grep → original grep
find → fd          \find → original find
cd  → z (zoxide)   \cd  → original cd
du  → dust         \du  → original du
top → btop         \top → original top
```

## Tmux Cheatsheet

| Key | Action |
|-----|--------|
| `Ctrl+A` | Prefix |
| `Prefix, \|` | Split vertical |
| `Prefix, -` | Split horizontal |
| `Prefix, h/j/k/l` | Navigate panes |
| `Prefix, c` | New window |
| `Prefix, I` | Install TPM plugins |

## Git Delta

Add to your `~/.gitconfig`:

```ini
[include]
    path = ~/.gitconfig-delta
```

## File Locations

```
~/.zshrc                  → dotfiles/zsh/.zshrc
~/.config/starship.toml   → dotfiles/starship/starship.toml
~/.config/tmux/tmux.conf  → dotfiles/tmux/.tmux.conf
~/.gitconfig-delta        → dotfiles/git/.gitconfig-delta
~/.zsh/plugins/           → zsh plugins (cloned by install.sh)
~/.tmux/plugins/tpm/      → TPM (cloned by install.sh)
```
