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
eval "$(rbenv init - zsh)"

#
# kubectl completions
#
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

### iTerm2 shell integration ###
# https://iterm2.com/documentation-shell-integration.html
# For safety, first verify that the file actually exists and that this is an
# OSX box in case I accidentally stow'd the file from my dotfiles on a different platform
if [[ -s "${ZDOTDIR:-$HOME}/.iterm2_shell_integration.zsh" && "$OSTYPE" = darwin* ]]; then
  source "${ZDOTDIR:-$HOME}/.iterm2_shell_integration.zsh"
fi
