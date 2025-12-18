#!/bin/bash

while true; do

read -p "Would you like to install Steam (y/n) " yn
case $yn in
  [yY] ) echo "Initializing Steam installer...";
    break;;
  [nN] ) echo "Steam will not be installed. Please reboot system. To access bios directly, type: systemctl reboot --firmware-setup in the terminal.";
    exit;;
  * ) echo "Invalid response. Please specify (y/n)";;
esac

done
sleep 1
clear
echo "Steam will now be installed. If prompted to select your drivers reccomendations are as follows:"
echo
sleep 1
echo "For AMD GPUs, please use vulkan-radeon."
echo
sleep 2
echo "NVIDIA GPUs should already have proper driver support from this installer. If you are prompted to select"
echo "one regardless, use nvidia-utils."
sleep 5
echo "Installing..."
sudo pacman --needed -S steam
echo
sed -i "/exec-once/"'s/^#//' ~/.config/hypr/autostart.conf
echo "Steam installed. System will reboot to BIOS in 5 seconds..."
sleep 5
systemctl reboot --firmware-setup
