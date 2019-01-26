#!/bin/sh

install_python3 () {
  # Install user required python packages - ignored required env
  PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user -r requirements.txt
}

install_ruby () {
  # Set gem home to local user path
  export GEM_HOME="$(gem env home)"
  # Install bundler to read Gemfile for current user
  gem install bundler
  bundle install

  # TODO: Should add zsh completion as described: https://github.com/tmuxinator/tmuxinator
}

install_flutter() {
  # TODO: Should probably have a check if folder already exists
  git clone https://github.com/flutter/flutter.git ~/code/flutter
}

initialize_cocoapods() {
  # NOTE: This is dependent on cocoapods is installed
  pod setup
}

install_ruby
#install_python3
#install_flutter
#initialize_cocoapods
