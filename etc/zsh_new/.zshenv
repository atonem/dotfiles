# zsh
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export EDITOR="nvim"
export VISUAL="nvim"

# n (node version handler)
export HOMEBREW_PATH="/opt/homebrew/bin"

path=(
  $HOME/n/bin
  $HOME/.bin
  $HOME/bin
  $HOMEBREW_PATH
  $path
  $HOME/.local/bin
  "${HOME}/Library/Python/3.8/bin"
)

# the-way
export THE_WAY_DIR=$XDG_CONFIG_HOME/the-way
export THE_WAY_CONFIG=$THE_WAY_DIR/config.toml

# other
export TURBO_TELEMETRY_DISABLED=1
export HOMEBREW_NO_ANALYTICS=1

# secrets
if [[ -a "$HOME/dotfiles/.env" ]]; then
  source "$HOME/dotfiles/.env"
fi
