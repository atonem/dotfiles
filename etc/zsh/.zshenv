#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

#
# Defines environment variables.
#

# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1

# http://disq.us/p/f55b78
setopt noglobalrcs
export NEXT_TELEMETRY_DISABLED='1'

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export HOMEBREW_PATH="/opt/homebrew/bin"

path=(
  $HOME/n/bin
  $HOME/.bin
  $HOME/bin
  $HOMEBREW_PATH
  $PATH
)

# completions
fpath=(
  $(brew --prefix)/share/zsh/site-functions
  $fpath
)

# initialize comp
autoload -Uz compinit
compinit

# XDG (WIP)
export XDG_CONFIG_HOME="$HOME/.config"

# the-way
export THE_WAY_DIR=$HOME/.config/the-way
export THE_WAY_CONFIG=$THE_WAY_DIR/config.toml

# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

#
# Golang
#
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

#
# Rust
#
export PATH="$PATH:${HOME}/.cargo/bin"

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


# Python
# TODO: Load lazy

export PATH=$HOME/.local/bin:$PATH

# fix zsh cursor disappearing
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

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
# export PYENV_ROOT="/usr/local/var/pyenv"
# export PYENV_DIR="$HOME/.config/pyenv"
# export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

#
# Ruby
#
# setting version this way is more convenient than som file
export RBENV_VERSION="3.1.0"
export RBENV_ROOT="/usr/local/var/rbenv"
export PATH="$RBENV_ROOT/shims:$PATH"


# set archflags to include arm64
export ARCHFLAGS="-arch x86_64 -arch arm64"

# Custom environment vars... Custom scripts generally go in .zshrc since it's
# only loaded for interactive shells.
# node version handler
export N_PREFIX=$HOME/n
