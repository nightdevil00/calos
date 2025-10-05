#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

clear
echo "Installation Starting..."
echo
echo "Please note, this install script will make the current user the default for the login process, bypassing the input user prompt."
sleep 1
echo "If you would like to change that, make sure to edit (or remove) /etc/systemd/system/getty@tty1.service.d/skip-username.conf (requires sudo)"
sleep 1
echo "Only do this if you would like to allow multiple user/DE logins or change the default user login!"
sleep 5
echo
echo
echo "Ready?"
echo
echo

echo "ExecStart=-/sbin/agetty -o '-p -- $USER' --noclear --skip-login - "'$TERM' | tee -a install/skip-username.conf

sleep 1

# Preparation
source $CALOS_INSTALL/preflight/show-env.sh
source $CALOS_INSTALL/preflight/trap-errors.sh
source $CALOS_INSTALL/preflight/chroot.sh
source $CALOS_INSTALL/preflight/repositories.sh

# Packaging
source $CALOS_INSTALL/packages.sh
source $CALOS_INSTALL/packaging/fonts.sh
source $CALOS_INSTALL/packaging/lazyvim.sh
source $CALOS_INSTALL/packaging/tuis.sh

# Configuration
source $CALOS_INSTALL/config/config.sh
source $CALOS_INSTALL/config/theme.sh
source $CALOS_INSTALL/config/branding.sh
# source $CALOS_INSTALL/config/git.sh
source $CALOS_INSTALL/config/increase-sudo-tries.sh
source $CALOS_INSTALL/config/increase-lockout-limit.sh
source $CALOS_INSTALL/config/ssh-flakiness.sh
source $CALOS_INSTALL/config/detect-keyboard-layout.sh
source $CALOS_INSTALL/config/localdb.sh
source $CALOS_INSTALL/config/hardware/network.sh
# source $CALOS_INSTALL/config/hardware/fix-fkeys.sh
source $CALOS_INSTALL/config/hardware/bluetooth.sh
source $CALOS_INSTALL/config/hardware/usb-autosuspend.sh
source $CALOS_INSTALL/config/hardware/ignore-power-button.sh
source $CALOS_INSTALL/config/hardware/nvidia.sh

# Login
source $CALOS_INSTALL/login/limine.sh

sudo cp ~/.local/share/calos/install/boot.jpg /boot/boot.jpg
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile

echo "Creating login service."

sudo mkdir /etc/systemd/system/getty@tty1.service.d
sudo cp ~/.local/share/calos/install/skip-username.conf /etc/systemd/system/getty@tty1.service.d/skip-username.conf
sudo cp ~/.local/share/calos/install/issue /etc/issue
sudo cp ~/.local/share/calos/install/motd /etc/motd
yay -S --noconfirm --needed rose-pine-hyprcursor
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

# Reboot
echo
echo
echo "Installation completed. Reboot to access system."
echo "Prior to reboot, navigate to ~/.config/hypr/ and use nano to edit the 'monitors.conf' file with your proper resolution/refresh rate."
echo
