# ---------------------------------------------------------------------------
# History
# ---------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicates
setopt HIST_FIND_NO_DUPS     # Don't show dupes when searching
setopt HIST_REDUCE_BLANKS    # Trim whitespace
setopt SHARE_HISTORY         # Sync across sessions
setopt APPEND_HISTORY        # Append instead of overwrite
setopt INC_APPEND_HISTORY    # Write immediately, not on exit
setopt AUTO_CD               # Type a dir path to cd into it

# ---------------------------------------------------------------------------
# Completion
# ---------------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Case-insensitive
zstyle ':completion:*' menu select                     # Menu selection

# ---------------------------------------------------------------------------
# Plugins
# ---------------------------------------------------------------------------
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# History substring search key bindings
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow

# Autosuggestion strategy
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ---------------------------------------------------------------------------
# Modern CLI aliases (originals still accessible via \ls, \cat, etc.)
# ---------------------------------------------------------------------------
alias ls='eza --icons --group-directories-first'
alias ll='eza --icons --group-directories-first -la'
alias la='eza --icons --group-directories-first -a'
alias tree='eza --icons --tree'
alias cat='bat --paging=never'
alias grep='rg'
alias find='fd'
alias du='dust'
alias top='btop'
alias zs='source ~/.zshrc'
alias zc='nvim ~/.zshrc'

# ---------------------------------------------------------------------------
# PATH
# ---------------------------------------------------------------------------
# Homebrew / Linuxbrew
eval "$(brew shellenv 2>/dev/null || true)"

# Common user paths
[[ -d "$HOME/.bun/bin" ]]   && export PATH="$HOME/.bun/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# ---------------------------------------------------------------------------
# Tool init
# ---------------------------------------------------------------------------
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# fzf key bindings and completion
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# zoxide alias (cd → z)
alias cd='z'
