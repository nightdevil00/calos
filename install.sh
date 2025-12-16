#!/bin/bash
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

clear

#echo "ExecStart=-/sbin/agetty -o '-p -- $USER' --noclear --skip-login - "'$TERM' | tee -a install/skip-username.conf

sleep 1
echo "Welcome to calOS! The installer will begin by enabling the Chaotic-AUR to help make the install faster and more reliable"
echo "yay will be installed by default. If you would like to remove Chaotic-AUR after the installation, proceed to /etc/pacman.conf"
echo "and remove the final two lines. Don't forget to uncomment multi-lib for Steam support as well!"
sleep 2
echo
echo "Installation starting..."
sleep 4
source $CALOS_INSTALL/preflight/trap-errors.sh
source $CALOS_INSTALL/preflight/chroot.sh
source $CALOS_INSTALL/preflight/repositories.sh

sudo pacman -S --needed base-devel
sudo pacman -S --noconfirm --needed yay
clear
echo "Chaotic-AUR and yay have been installed. Now installing core utils."
sleep 2
sudo pacman -S --noconfirm --needed yaru-icon-theme clipse
#git clone https://aur.archlinux.org/paru.git
#cd paru
#makepkg -si --noconfirm

#echo "paru installed! Resuming install..."
#sleep 5
#clear
#cd ~/.local/share/calos

# paru -S --noconfirm --needed python-terminaltexteffects rose-pine-hyprcursor gpu-screen-recorder elephant elephant-desktopapplications elephant-menus elephant-calc walker --skipreview --removemake --cleanafter
yay -S --noconfirm --needed python-terminaltexteffects rose-pine-hyprcursor gpu-screen-recorder elephant elephant-desktopapplications elephant-menus elephant-calc walker --removemake --cleanafter

clear
echo "All utils successfully installed."
echo "Main packages and configuration files will now be installed..."
sleep 3

source $CALOS_INSTALL/packages.sh
source $CALOS_INSTALL/packaging/fonts.sh
source $CALOS_INSTALL/packaging/lazyvim.sh
source $CALOS_INSTALL/packaging/tuis.sh
source $CALOS_INSTALL/config/config.sh
source $CALOS_INSTALL/config/theme.sh
source $CALOS_INSTALL/config/branding.sh
source $CALOS_INSTALL/config/increase-sudo-tries.sh
source $CALOS_INSTALL/config/increase-lockout-limit.sh
source $CALOS_INSTALL/config/localdb.sh
source $CALOS_INSTALL/config/hardware/network.sh
source $CALOS_INSTALL/config/hardware/bluetooth.sh
source $CALOS_INSTALL/config/hardware/usb-autosuspend.sh
source $CALOS_INSTALL/config/hardware/ignore-power-button.sh
clear
echo "Checking for and installing Nvidia drivers if necessary..."
sleep 1

source $CALOS_INSTALL/nvidia.sh
clear 
echo "Resuming Installation"
sleep 2
source $CALOS_INSTALL/limine.sh

sudo cp ~/.local/share/calos/install/boot.jpg /boot/boot.jpg
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile
sleep 2
clear
echo "Creating login service."
sleep 2
sudo cp ~/.local/share/calos/install/greet-config.toml /etc/greetd/config.toml
sudo cp ~/.local/share/calos/install/motd /etc/motd
# paru -S --noconfirm --needed rose-pine-hyprcursor --skipreview --removemake --cleanafter
echo "$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/systemctl start bootmsg.service" | sudo tee "/etc/sudoers.d/no-bootmsg-prompt"
sudo cp ~/.local/share/calos/install/bootmsg.service /etc/systemd/system/bootmsg.service
echo
echo "Boot message service added and enabled."
sleep 3
xdg-settings set default-web-browser firefox.desktop

echo
echo
clear
echo "Enabling polkit service and applying miscellaneous fixes..."
sleep 2
echo
systemctl --user enable --now hyprpolkitagent.service
sudo chmod 666 /dev/uinput
sudo pacman -Rdd greetd-agreety --noconfirm
sudo systemctl enable greetd.service
echo

echo "Configuring Walker, Elephant and Waybar as services..."
elephant service enable
systemctl --user enable elephant.service
systemctl --user start elephant.service
systemctl --user enable waybar.service
echo
echo
sleep 2
echo "Cleaning up installation..."
sudo rm -rf ~/go/
rm -rf ~/.local/share/calos/paru/
chmod +x ~/.local/share/calos/bin/calos-pkg-list
rm ~/.local/share/calos/bin/calos-tui-install
cp ~/.local/share/calos/applications/hidden/* ~/.local/share/applications/
cp ~/.local/share/calos/applications/nvim.desktop ~/.local/share/applications/
cp ~/.local/share/calos/applications/limine-snapper-restore.desktop ~/.local/share/applications/
sudo pacman -Rns maven --noconfirm
#sudo pacman -Rns rust --noconfirm

cat ~/.local/share/calos/logo.txt
# Reboot
echo
echo
echo "Installation completed. Reboot to access system."
echo "Make sure to read through your configuration files to familarize yourself with operations!"
echo "Please check the configuration files under ~/.config/hypr especially. This is how you interact with your system."
echo
