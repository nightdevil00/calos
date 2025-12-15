#!/bin/bash
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

clear

#echo "ExecStart=-/sbin/agetty -o '-p -- $USER' --noclear --skip-login - "'$TERM' | tee -a install/skip-username.conf

sleep 1
#source $CALOS_INSTALL/preflight/show-env.sh
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

paru -S --noconfirm --needed walker python-terminaltexteffects gpu-screen-recorder yaru-icon-theme elephant clipse elephant-desktopapplications --skipreview --removemake --cleanafter

source $CALOS_INSTALL/packages.sh
source $CALOS_INSTALL/packaging/fonts.sh
source $CALOS_INSTALL/packaging/lazyvim.sh
source $CALOS_INSTALL/packaging/tuis.sh
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
source $CALOS_INSTALL/limine.sh

sudo cp ~/.local/share/calos/install/boot.jpg /boot/boot.jpg
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile
sleep 2
clear
echo "Creating login service."
sleep 2

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
sleep 3
xdg-settings set default-web-browser firefox.desktop

echo
echo
clear
echo "Enabling polkit service and applying miscellaneous fixes."
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
sudo pacman -Rns maven --noconfirm
sudo pacman -Rns rust --noconfirm

cat ~/.local/share/calos/logo.txt
# Reboot
echo
echo
echo "Installation completed. Reboot to access system."
echo "Make sure to read through your configuration files to familarize yourself with operations!"
echo "Please check the configuration files under ~/.config/hypr especially. This is how you interact with your system."
echo
echo
