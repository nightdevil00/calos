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
sleep 1
clear
echo "Steam will now be installed. If prompted to select your driver, make sure to specify vulkan-radeon."
sleep 3
echo "Installing..."
sudo pacman --needed -S steam
echo
sed -i "/exec-once/"'s/^#//' ~/.config/hypr/autostart.conf
echo "Steam installed. System will reboot in 5 seconds..."
sleep 5
systemctl reboot
