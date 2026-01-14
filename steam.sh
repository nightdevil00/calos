#!/bin/bash

gum style --border normal --border-foreground 212 --padding="1 3" "Steam will now be installed. If prompted to select your drivers reccomendations are as follows." "For AMD GPUs, please use vulkan-radeon. For the second prompt, if asked, use lib32-vulkan-radeon." "NVIDIA GPUs should already have proper driver support from this installer."
echo
sleep 8
gum spin -s line --title="Install Steam..." -- sleep 2
sudo pacman --needed -S steam
echo
sed -i "/exec-once/"'s/^#//' ~/.config/hypr/autostart.conf
gum spin -s line --title=""Steam installed. System will reboot to BIOS in 5 seconds..."" -- sleep 5
rm -rf ~/.local/share/calos/steam.sh
systemctl reboot --firmware-setup
