#!/bin/bash

# Got to have the PACMANs (copy right bandai namco 1923)
if ! grep -q "ILoveCandy" /etc/pacman.conf; then
  sudo sed -i '/^\[options\]/a Color\nILoveCandy\nVerbosePkgLists' /etc/pacman.conf
fi

# Add Chaotic AUR to make the install less cancer with less shit to build

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

if ! grep -q "chaotic-aur" /etc/pacman.conf; then
  echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf >/dev/null
  else
  echo -e "Chaotic-AUR already found in pacman.conf. Resuming install..."
fi

# Enable multilib for Steam and Nvidia fuckery, steam install will take place later on 

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Refresh all repos
sudo pacman -Syu --noconfirm
