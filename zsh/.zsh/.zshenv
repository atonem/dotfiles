#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

#
# Defines environment variables.
#

# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
# skip_global_compinit=1

# http://disq.us/p/f55b78
setopt noglobalrcs

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Custom environment vars... Custom scripts generally go in .zshrc since it's
# only loaded for interactive shells.

# Prepend rbenv for ruby version in path
# export PATH="$HOME/.rbenv/bin:$PATH"

#
# nvm (node version manager)
#
# Load nvm and it's autocompletions first when called
# https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs/
declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

NODE_GLOBALS+=("node")
NODE_GLOBALS+=("nvm")
NODE_GLOBALS+=("yarn")

load_nvm () {
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

for cmd in "${NODE_GLOBALS[@]}"; do
  eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done


#
# tmuxinator completions
# lazy loaded via function warpping
#
tmuxinator() {
  unset -f tmuxinator
  cd $HOME/dotfiles # Need to be in dotfiles dir (should prob use env) for bundle to work
    source "$(bundle show tmuxinator)/completion/tmuxinator.zsh"
    cd - &> /dev/null # Change back to previous working dir and dont print it
    tmuxinator "$@"
  }

mux() {
  unset -f mux
  cd $HOME/dotfiles # Need to be in dotfiles dir (should prob use env) for bundle to work
    source "$(bundle show tmuxinator)/completion/tmuxinator.zsh"
    cd - &> /dev/null # Change back to previous working dir and dont print it
    alias mux="tmuxinator"
    tmuxinator "$@"
  }
