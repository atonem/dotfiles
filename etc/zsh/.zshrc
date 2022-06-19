# !/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

# profile zsh startup
# zmodload zsh/zprof


#
# Executes commands at the start of an interactive session.
#

# Remove annoying empty whitespace to the right
export ZLE_RPROMPT_INDENT=watwat

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# n (node version handler)
export N_PREFIX=$HOME/n
export HOMEBREW_PATH="/opt/homebrew/bin"
path=(
  $HOME/n/bin
  $HOME/.bin
  $HOMEBREW_PATH
  $path
  "${HOME}/Library/Python/3.8/bin"
)

# aliases
source "${ZDOTDIR:-$HOME}/.aliases"

# keybinds
# bindkey '^I' autosuggest-accept

# Disable powerlin
# if [[ -s "${ZDOTDIR:-$HOME}/.promptline_theme" ]]; then
#   source "${ZDOTDIR:-$HOME}/.promptline_theme"
# fi

#
# Golang
#
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

#
# Secrets
#
if [[ -a "$HOME/dotfiles/.env" ]]; then
  source "$HOME/dotfiles/.env"
fi


#
# fzf completions and configuration
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --hidden --files'
export FZF_DEFAULT_OPTS='--layout=reverse --height=40%'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#
# load zsh plugins
#
source "${HOME}/.zgen/zgen.zsh"
zgen load urbainvaes/fzf-marks


#
# Android dev
# NOTE: Set here so that correct emulator is in path
#
#export ANT_HOME="/usr/local/opt/ant"
#export MAVEN_HOME="/usr/local/opt/maven"
#export GRADLE_HOME="/usr/local/opt/gradle"
#export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
# export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
# export ANDROID_HOME=$ANDROID_SDK_ROOT
# path=(
#   $ANDROID_HOME/emulator
#   $ANDROID_HOME/tools
#   $ANDROID_HOME/platform-tools
#   $path
# )

#
# Python
# TODO: Load lazy

export PATH=$HOME/.local/bin:$PATH

# fix zsh cursor disappearing
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)


#
# Lazy loading env managers
#
source "${ZDOTDIR:-$HOME}/lazy_loader.sh"

#
# Java
#
# declare -a JAVA_GLOBALS=($(/bin/ls -1A "$HOME/.jenv/shims"))
#
# jenv_init() {
#   eval "$(jenv init -)"
# }

# lazy_load jenv_init "${JAVA_GLOBALS[@]}"

#
# Python
#
export PIP_REQUIRE_VIRTUALENV=true
export PYENV_ROOT="/usr/local/var/pyenv"
export PYENV_DIR="$HOME/.config/pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims::$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#
#
# Ruby
#
# setting version this way is more convenient than som file
export RBENV_VERSION="3.1.0"
export RBENV_ROOT="/usr/local/var/rbenv"
export PATH="$RBENV_ROOT/shims:$PATH"
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

# set archflags to include arm64
export ARCHFLAGS="-arch x86_64 -arch arm64"

# Starship
eval "$(starship init zsh)"
