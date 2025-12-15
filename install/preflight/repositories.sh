#!/bin/bash

# Install build tools
sudo pacman -S --needed --noconfirm base-devel

# Add fun and color and verbosity to the pacman installer
if ! grep -q "ILoveCandy" /etc/pacman.conf; then
  sudo sed -i '/^\[options\]/a Color\nILoveCandy\nVerbosePkgLists' /etc/pacman.conf
fi

# Set mirrors to global ones only
# echo -e "Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch\nServer = https://mirror.rackspace.com/archlinux/\$repo/os/\$arch" |
#  sudo tee /etc/pacman.d/mirrorlist >/dev/null

# Add Chaotic AUR to make the install less cancer

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf >/dev/null

# Refresh all repos
sudo pacman -Syu --noconfirm
