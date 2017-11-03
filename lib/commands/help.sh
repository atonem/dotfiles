help_command () {
  echo "version: $(dotfiles_version)"
  echo ""
  cat "$(dotfiles_dir)/help.txt"
}
