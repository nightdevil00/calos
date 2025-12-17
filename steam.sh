#!/bin/bash

while true; do

read -p "Would you like to install Steam (y/n) " yn
case $yn in
  [yY] ) echo "Installing Steam...";
    break;;
  [nN] ) echo "Steam will not be installed. Please reboot system.";
    exit;;
  * ) echo "Invalid response. Please specify (y/n)";;
esac

done

sudo pacman --noconfirm --needed -S steam
clear
echo "Steam installed. System will not reboot..."
sleep 5
systemctl reboot
