#!/bin/bash

while true; do

read -p "Would you like to install Steam (y/n) " yn
case $yn in
  [yY] ) echo "Installing Steam...";
    break;;
  [nN] ) echo "Steam will not be installed.";
    exit;;
  * ) echo "Invalid response. Please specify (y/n)";;
esac

done

sudo pacman --noconfirm --needed -S steam
