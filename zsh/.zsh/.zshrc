#!/usr/bin/env zsh
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
path=(
  $path
  $HOME/n/bin
)

### Pip (Python) ###
# pip should only run if there is a virtualenv currently activated
# prevents accidentally installing packages without a virtualenv
export PIP_REQUIRE_VIRTUALENV=true
# create syspip workaround
syspip2(){
  #PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}
syspip3(){
  #PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# aliases
source $HOME/.aliases

# Disable powerlin
# if [[ -s "${ZDOTDIR:-$HOME}/.promptline_theme" ]]; then
#   source "${ZDOTDIR:-$HOME}/.promptline_theme"
# fi

#
# Golang
#
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export HOMEBREW_PATH="$(brew --prefix)/bin"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$HOMEBREW_PATH:$PATH"

#
# Secrets
#
if [[ -a "$HOME/dotfiles/.env" ]]; then
  source "$HOME/dotfiles/.env"
fi




#
# Dart path
#
export PATH=$HOME/.pub-cache/bin:$PATH

#
# fzf completions and configuration
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# profile zsh startup
# zprof
export PATH="/usr/local/opt/mysql-client/bin:$PATH"


#
# Android dev
# NODE: Set here so that correct emulator is in path
#
#export ANT_HOME="/usr/local/opt/ant"
#export MAVEN_HOME="/usr/local/opt/maven"
#export GRADLE_HOME="/usr/local/opt/gradle"
#export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME=$ANDROID_SDK_ROOT
path=(
  $ANDROID_HOME/emulator
  $ANDROID_HOME/tools
  $ANDROID_HOME/platform-tools
  $path
)

#
# Python
export PYENV_ROOT="/usr/local/var/pyenv"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH=$HOME/.local/bin:$PATH

export PS1='$(task +in +PENDING count) '$PS1

# Starship
eval "$(starship init zsh)"
