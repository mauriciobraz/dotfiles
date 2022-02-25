#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

install() {
  rsync -avh --no-perms dotfiles/.??* $HOME/
  echo "installed dotfiles"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  install
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    install
  fi
fi
