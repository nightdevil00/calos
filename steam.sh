#!/bin/bash

gum style --border normal --border-foreground 212 --padding="1 3" "Steam will now be installed. If prompted to select your repository/drivers choose the following:" "You may use either the $(gum style --italic 'extra') repository or $(gum style --italic 'chaotic-aur')." " " "For AMD GPUs, please use $(gum style --bold --foreground 212 'vulkan-radeon'). For the second prompt, if asked, use $(gum style --bold --foreground 212 'lib32-vulkan-radeon')." "NVIDIA GPUs should already have total proper driver support from this installer."
echo
sleep 8
gum spin -s line --title="Installing Steam..." -- sleep 2
sudo pacman --needed -S steam
echo
sed -i "/exec-once/"'s/^#//' ~/.config/hypr/autostart.conf
clear
rm -rf ~/.local/share/calos/steam.sh
