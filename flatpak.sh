#!/usr/bin/env bash

command -v flatpak &>/dev/null || {
  echo "Flatpak is not installed, please install it first."
  exit
}

# Install Flatpak apps, to add new ones, separe the repo for the appid using ":",
# e.g. `flathub:com.spotify.Client`.
flatpak_apps=(
  flathub:com.spotify.Client
  flathub:com.mattjakeman.ExtensionManager
  flathub-beta:com.discordapp.DiscordCanary
)

#* You can pass custom arguments to the flatpak command, e.g. `sh install.sh --system`.
#* By default, the `--assumeyes` flag is used.
for app in "${flatpak_apps[@]}"; do
  APP_ID=$(echo $app | cut -d ':' -f 2)
  REPO=$(echo $app | cut -d ':' -f 1)

  flatpak install $REPO $APP_ID $@ --assumeyes
done
