#!/usr/bin/env bash

# Stop executing if is non-sudo user
if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root."
  echo "Try 'sudo $0'"

  exit
fi

force=false

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  force=true
fi

# Install tools that I use using dnf (Fedora's package manager)
# Update the already installed packages.
dnf update -y

command -v git >/dev/null &>/dev/null || {
  dnf install -y git-all
}

command -v zsh >/dev/null &>/dev/null || {
  dnf install -y zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  usermod --shell $(which zsh) $USER
}

# Install Flatpak if not installed.
command -v flatpak &>/dev/null || {
  if [[ $force == true ]]; then
    dnf install -y flatpak
  else
    read -p "Install flatpak? (y/N) " -n 1
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      dnf install -y flatpak
    fi
  fi
}

# If Flatpak is installed, we'll install some apps using it.
command -v flatpak &>/dev/null && {
  flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo

  flatpak remote-add --if-not-exists flathub-beta \
    https://flathub.org/beta-repo/flathub-beta.flatpakrepo

  # Applications available in the `flathub` repository.
  flathub_apps=(
    com.spotify.Client
    com.discordapp.Discord
  )

  for app_name in ${flathub_apps[@]}; do
    flatpak install flathub -y $app_name
  done
}

# Install VS Code with dnf if not installed.
command -v code &>/dev/null || {
  install-code() {
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    dnf install -y code
  }

  if [[ $force == true ]]; then
    install-code
  else
    read -p "Install VS Code? (y/N) " -n 1
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      install-code
    fi
  fi

  unset install-code

  # Install an syncronization tool for VS Code.
  # Usage: https://github.com/shanalikhan/code-settings-sync
  code --install-extension Shan.code-settings-sync
}

# Naver Whale web browser, optional.
command -v naver-whale &>/dev/null || {
  install-naver-whale() {
    download_url="https://installer-whale.pstatic.net/downloads/installers/naver-whale-stable_amd64.deb"
    output_file="/tmp/naver-whale.deb"

    curl $download_url -o $output_file

    command -v alien &>/dev/null || {
      dnf install -y alien
    }

    alien --to-rpm --install $output_file
  }

  if [[ $force == true ]]; then
    install-naver-whale
  else
    read -p "Install Naver Whale? (y/N) " -n 1
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      install-naver-whale
    fi
  fi

  unset install-naver-whale
}
