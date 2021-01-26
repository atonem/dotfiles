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

# jenv
# lazy load jenv
jenv() {
  unset -f jenv
  eval "$(jenv init -)"
  jenv "$@"
}

#
# nvm (node version manager)
#
# Load nvm and it's autocompletions first when called
# https://www.reddit.com/r/node/comments/4tg5jg/lazy_load_nvm_for_faster_shell_start/d5ib9fs/

# load_nvm () {
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#   [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# }
#
# declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)
#
# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")


# for cmd in "${NODE_GLOBALS[@]}"; do
#   eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
# done
