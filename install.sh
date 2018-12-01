#!/bin/sh

install_python3 () {
  # Install user required python packages - ignored required env
  PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --user -r requirements.txt
}

install_ruby () {
  # Set gem home to local user path
  export GEM_HOME="$(ruby -r rubygems -e 'puts Gem.user_dir')"
  # Install bundler to read Gemfile for current user
  gem install bundler
  bundle install

  # TODO: Should add zsh completion as described: https://github.com/tmuxinator/tmuxinator
}

install_ruby
install_python3

