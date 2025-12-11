#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

clear

#echo "ExecStart=-/sbin/agetty -o '-p -- $USER' --noclear --skip-login - "'$TERM' | tee -a install/skip-username.conf

sleep 1

# Preparation
source $CALOS_INSTALL/preflight/show-env.sh
source $CALOS_INSTALL/preflight/trap-errors.sh
source $CALOS_INSTALL/preflight/chroot.sh
source $CALOS_INSTALL/preflight/repositories.sh

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm

echo "paru installed! Resuming install..."
sleep 5
clear
cd ~/.local/share/calos

paru -S --noconfirm walker --skipreview --removemake --cleanafter
paru -S --noconfirm python-terminaltexteffects --skipreview --removemake --cleanafter
paru -S --noconfirm gpu-screen-recorder --skipreview --removemake --cleanafter
paru -S --noconfirm yaru-icon-theme --skipreview --removemake --cleanafter

# Packaging
source $CALOS_INSTALL/packages.sh
source $CALOS_INSTALL/packaging/fonts.sh
source $CALOS_INSTALL/packaging/lazyvim.sh
source $CALOS_INSTALL/packaging/tuis.sh

# Configuration
source $CALOS_INSTALL/config/config.sh
source $CALOS_INSTALL/config/theme.sh
source $CALOS_INSTALL/config/branding.sh
source $CALOS_INSTALL/config/increase-sudo-tries.sh
source $CALOS_INSTALL/config/increase-lockout-limit.sh
source $CALOS_INSTALL/config/ssh-flakiness.sh
source $CALOS_INSTALL/config/localdb.sh
source $CALOS_INSTALL/config/hardware/network.sh
source $CALOS_INSTALL/config/hardware/bluetooth.sh
source $CALOS_INSTALL/config/hardware/usb-autosuspend.sh
source $CALOS_INSTALL/config/hardware/ignore-power-button.sh

# Login
source $CALOS_INSTALL/login/limine.sh

sudo cp ~/.local/share/calos/install/boot.jpg /boot/boot.jpg
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile

echo "Creating login service."

#sudo mkdir /etc/systemd/system/getty@tty1.service.d
#sudo cp ~/.local/share/calos/install/skip-username.conf /etc/systemd/system/getty@tty1.service.d/skip-username.conf
sudo cp ~/.local/share/calos/install/greet-config.toml /etc/greetd/config.toml
sudo cp ~/.local/share/calos/install/issue /etc/issue
sudo cp ~/.local/share/calos/install/motd /etc/motd
paru -S --noconfirm --needed rose-pine-hyprcursor
echo "$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/systemctl start bootmsg.service" | sudo tee "/etc/sudoers.d/no-bootmsg-prompt"
sudo cp ~/.local/share/calos/install/bootmsg.service /etc/systemd/system/bootmsg.service
echo
echo "Boot message service added and enabled."

xdg-settings set default-web-browser firefox.desktop

echo
echo
echo "Enabling polkit service and applying miscellaneous fixes."

systemctl --user enable --now hyprpolkitagent.service
sudo chmod 666 /dev/uinput

sudo pacman -Rns maven
sudo pacman -Rdd greetd-agreety
sudo systemctl enable greetd.service

echo "Configuring Elephant..."
elephant service enable
sudo systemctl --user start elephant.service
sleep 4


# Reboot
echo
echo
echo "Installation completed. Reboot to access system."
echo "Prior to reboot, navigate to ~/.config/hypr/ and use nano to edit the 'monitors.conf' file with your proper resolution/refresh rate."
echo "For further system tuning, please look into removing elephant and waybar as an exec-once variable in your hyprland configuration and adding them as system services."
echo
