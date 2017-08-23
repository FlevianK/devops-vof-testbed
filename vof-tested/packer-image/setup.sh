#!/usr/bin/env bash

set -ex

install_dependancies() {
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends git-core curl zlib1g-dev \
  build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev  \
  sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev wget nodejs      \
  python-software-properties libffi-dev postgresql postgresql-contrib    \
  libpq-dev
}

install_ruby() {
  #Give user vof write and execute permission
  sudo chown -R vof /usr/local

  mkdir /tmp/workspace
  pushd /tmp/workspace
    curl -L -O  https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz
    tar zxf ruby-2.4.1.tar.gz

    pushd ruby-2.4.1
      ./configure
      make && make install
    popd
  popd

  rm -rf /tmp/workspace
}

install_ruby_dependencies() {
  curl -L -O https://rubygems.org/downloads/bundler-1.15.4.gem
  curl -L -O https://rubygems.org/rubygems/rubygems-2.6.12.tgz

  tar xzf rubygems-2.6.12.tgz
  pushd rubygems-2.6.12
    ruby setup.rb
  popd
  gem install bundler-1.15.4.gem --local --no-ri --no-rdoc
}

main() {
  install_dependancies

  install_ruby

  install_ruby_dependencies
}

main "$@"
