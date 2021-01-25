#!/usr/bin/env zsh
# vim:syntax=zsh
# vim:filetype=zsh

#
# Executes commands at login post-zshrc.
#

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# To get correct ruby path from rbenv
# TODO: Fix this, should be lazy-laoded?

export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/shims:$PATH"
eval "$(rbenv init - zsh)"

#
# kubectl completions
#
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
