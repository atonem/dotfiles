#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "$HOME/.zshenv" ]]; then
  source $HOME/.zshenv
fi

if [[ -s "$HOME/.moonline" ]]; then
  source $HOME/.moonline/moonline.zsh && moonline initialize
fi


### Pip (Python) ###
# pip should only run if there is a virtualenv currently activated
# prevents accidentally installing packages without a virtualenv
export PIP_REQUIRE_VIRTUALENV=false
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


### iTerm2 shell integration ###
# https://iterm2.com/documentation-shell-integration.html
# For safety, first verify that the file actually exists and that this is an
# OSX box in case I accidentally stow'd the file from my dotfiles on a different platform
if [[ -s "$HOME/.iterm2_shell_integration.zsh" && "$OSTYPE" = darwin* ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

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
# nvm (node version manager)
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# kubectl completions
# 
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

#
# tmuxinator completions
#
cd $HOME/dotfiles # Need to be in dotfiles dir (should prob use env) for bundle to work
source "$(bundle show tmuxinator)/completion/tmuxinator.zsh"
cd - &> /dev/null # Change back to previous working dir and dont print it

#
# force load vim with custom config
#
#alias vim="vim -S ~/.vimrc"
alias vim="nvim -S ~/.vimrc"

#
# add default ignore command to tree
#
alias tree="tree -a -I 'node_modules|.git|.DS_Store' --dirsfirst"

eval "$(rbenv init - zsh)"
