#!/usr/bin/env bash

DEPENDENCIES=(
  rsync
  git
  zsh
)

for dependency in "${DEPENDENCIES[@]}"; do
  command -v $dependency &>/dev/null || {
    echo "Dependency $dependency is not installed, please install it first."
    exit
  }
done

cd "$(dirname "${BASH_SOURCE}")"

install() {
  rsync -avh --no-perms dotfiles/.??* $HOME/

  echo "dotfiles installed."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  install
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    install
  fi
fi
