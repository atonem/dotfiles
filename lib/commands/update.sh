update_command() {
  # TODO: add specific commands for homebrew, python, and ruby

  echo "Updating homebrew packages..."
  brew update
  echo "Done updating homebrew packages."

  echo "Updating pip packages..."
  PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user -r requirements.txt
  echo "Done updating pip packages."


  echo "Updating ruby packages..."
  bundle update --all
  echo "Done updating ruby packages."

}