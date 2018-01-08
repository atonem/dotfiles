# Usage of dotfiles repostiory
This is basic instructions of how to use this dotfiles repostiory.

## Homebrew
The homebrew packages are handled in the Brewfile.

## Ruby
The ruby dependencies are handled in the Gemfile.

## Python
Python dependencies are defined in requirements.txt

## Stow
To use/install the features, GNU stow is used, you simple enter the dotfiles directory and `stow .zsh` for example. This will create a symlink in the parent folder (i.e. home folder).

## Secrets
Secrets and non-versioned files are kept in the .env file which is sourced by zsh if available in `$HOME/dotfiles/.env`. Also note you might need to chmod +x on the .env file to be able to source it.

# TODO
Better install scripts, bot for installing brew, python and ruby packages. But also simplifying configuration of vim plugins.
