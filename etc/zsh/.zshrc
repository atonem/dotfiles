# !/usr/bin/env zsh

# profile zsh startup
# zmodload zsh/zprof

# avoid duplicates in path
typeset -U PATH

#
# Executes commands at the start of an interactive session.
#

# Remove annoying empty whitespace to the right
export ZLE_RPROMPT_INDENT=watwat

# mise
eval "$(mise activate zsh)"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# aliases
source "${ZDOTDIR:-$HOME}/.aliases"

# functions
source "${ZDOTDIR:-$HOME}/functions"

# chpwd profiles
# source "${ZDOTDIR:-$HOME}/profiles/init.zsh"


# keybinds
# bindkey '^I' autosuggest-accept

# Disable powerlin
# if [[ -s "${ZDOTDIR:-$HOME}/.promptline_theme" ]]; then
#   source "${ZDOTDIR:-$HOME}/.promptline_theme"
# fi

#
# load zsh plugins
#
source "${HOME}/.zgen/zgen.zsh"
zgen load urbainvaes/fzf-marks


#
# Lazy loading env managers
#
source "${ZDOTDIR:-$HOME}/lazy_loader.sh"

#
# Ruby
#
# setting version this way is more convenient than som file
# TODO: Load lazy
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

#
# zoxide
#
zoxide_init() {
  eval "$(zoxide init zsh)"
}

lazy_load zoxide_init "z"

#
# gcloud
#
# source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
# source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

#
# timewarrior command prompt
#
# tw_current() {
#   line=("${(@f)$(timew | grep --color=never Total | awk '{print $(NF)}')}")
#   export TW_TRACKING_TIME="${line}"
# }
#
# precmd_functions+=(tw_current)

#
# taskwarrior inbox
#
# task_inbox() {
#   export TASK_INBOX_COUNT="$(task +in +PENDING count)"
# }
#
# precmd_functions+=(task_inbox)

# Starship
eval "$(starship init zsh)"

# direnv
eval "$(direnv hook zsh)"

# nix
# source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
# source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

