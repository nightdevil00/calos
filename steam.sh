#!/bin/bash

gum style --border normal --border-foreground 212 --padding="1 3" "Steam will now be installed. If prompted to select your drivers choose the following." "For AMD GPUs, please use vulkan-radeon. For the second prompt, if asked, use lib32-vulkan-radeon." "NVIDIA GPUs should already have total proper driver support from this installer."
echo
sleep 8
gum spin -s line --title="Installing Steam..." -- sleep 2
sudo pacman --needed -S steam
echo
sed -i "/exec-once/"'s/^#//' ~/.config/hypr/autostart.conf
clear
rm -rf ~/.local/share/calos/steam.sh
