# We shouldn't rely on the user's grep settings to be correct. If we set these
# here anytime asdf invokes grep it will be invoked with these options
# shellcheck disable=SC2034
GREP_OPTIONS="--color=never"
# shellcheck disable=SC2034
GREP_COLORS=

dotfiles_version() {
  cat "$(dotfiles_dir)/VERSION"
}

dotfiles_dir() {
  if [ -z "$DOTFILES_DIR" ]; then
    local current_script_path=${BASH_SOURCE[0]}
    export DOTFILES_DIR
	DOTFILES_DIR=$(cd "$(dirname "$(dirname "$current_script_path")")" || exit; pwd)
  fi

  echo "$DOTFILES_DIR"
}

dotfiles_repository_url() {
  echo "https://github.com/atonem/dotfiles.git"
}
