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

# pip3 alias
alias pip3='python3 -m pip'
# venv alias
alias venv='python3 -m venv'

# Fix broken ls with correct values
alias ls='\ls -alhGP'

# Use exhuberant-ctags from homebrew
alias ctags="$(brew --prefix)/bin/ctags"


if [[ -s "${ZDOTDIR:-$HOME}/.promptline_theme" ]]; then
  source "${ZDOTDIR:-$HOME}/.promptline_theme"
fi

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
# force load vim with custom config
#
#alias vim="vim -S ~/.vimrc"
alias vim="nvim"

#
# add default ignore command to tree
#
alias tree="tree -a -I 'node_modules|.git|.DS_Store' --dirsfirst"

#
# Dart path
#
export PATH=$HOME/.pub-cache/bin:$PATH

#
# fzf completions and configuration
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# profile zsh startup
# zprof
