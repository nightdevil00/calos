#!/bin/bash
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

clear
sleep 1
echo "Welcome to calOS!"
echo
sleep 1
echo "Paru will be installed by default alongside the Chaotic-AUR repository. If you would like to remove Chaotic-AUR after the installation, proceed to /etc/pacman.conf"
echo "and remove the final two lines. The installer will also enable the multilib repositories by default. This helps with NVIDIA detection and Steam installation."
sleep 3
echo
echo "Installation starting..."
sleep 5
source $CALOS_INSTALL/preflight/trap-errors.sh
source $CALOS_INSTALL/preflight/repositories.sh

sudo pacman -S --needed base-devel
sudo pacman -S --noconfirm --needed paru
clear
echo "Chaotic-AUR repository synced and paru has been installed."
sleep 2
echo
echo "The installer will now begin installing AUR programs required for system functionality."
sleep 3
sudo pacman -S --noconfirm --needed yaru-icon-theme clipse

paru -S --noconfirm --needed python-terminaltexteffects rose-pine-hyprcursor gpu-screen-recorder elephant elephant-desktopapplications elephant-menus elephant-calc walker --skipreview --removemake --cleanafter
# yay -S --noconfirm --needed python-terminaltexteffects rose-pine-hyprcursor gpu-screen-recorder elephant elephant-desktopapplications elephant-menus elephant-calc walker --removemake --cleanafter

clear
echo "AUR system packages built and installed successfully! Build files will be cleaned post-installation."
sleep 3
echo
echo "Main packages and configuration files will now be installed..."
sleep 3

source $CALOS_INSTALL/packages.sh
source $CALOS_INSTALL/packaging/fonts.sh
source $CALOS_INSTALL/packaging/lazyvim.sh
source $CALOS_INSTALL/packaging/tuis.sh
source $CALOS_INSTALL/config/config.sh
source $CALOS_INSTALL/config/theme.sh
source $CALOS_INSTALL/config/branding.sh

clear
echo "Checking hardware for Nvidia GPU..."
echo
sleep 1
echo "Installer will download/update all required configuration files if found."
sleep 1
echo "If an AMD gpu is detected the installation script will instead enable rocm support for system integration."
sleep 4

source $CALOS_INSTALL/nvidia.sh
sleep 2
clear

echo "Limine bootloader configuration will now be installed."
sleep 1
echo "By default, snapper services are not configured but calOS allows for full Snapshot integration with the bootloader."
sleep 1
echo "Refer to limine-snapper-sync in order to complete this setup yourself."
sleep 1
echo
echo "Resuming Installation..."
sleep 5
source $CALOS_INSTALL/limine.sh
sudo cp ~/.local/share/calos/install/boot.jpg /boot/boot.jpg
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile
sleep 2
clear

echo "Creating login service..."
sleep 5
sudo cp ~/.local/share/calos/install/greet-config.toml /etc/greetd/config.toml
sudo cp ~/.local/share/calos/install/motd /etc/motd
echo "$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/systemctl start bootmsg.service" | sudo tee "/etc/sudoers.d/no-bootmsg-prompt"
sudo cp ~/.local/share/calos/install/bootmsg.service /etc/systemd/system/bootmsg.service
echo
echo "Boot message service added and enabled. This is located in your home directory's .bashrc file. Configure it as needed."
sleep 5
clear

echo "Enabling polkit service and applying miscellaneous fixes..."
sleep 3
xdg-settings set default-web-browser firefox.desktop
echo
systemctl --user enable --now hyprpolkitagent.service
sudo chmod 666 /dev/uinput
sudo pacman -Rdd greetd-agreety --noconfirm
sudo systemctl enable greetd.service
clear

echo "Configuring Walker, Elephant and Waybar as services..."
sleep 3
elephant service enable
systemctl --user enable elephant.service
systemctl --user start elephant.service
systemctl --user enable waybar.service
clear

echo "The installer will now begin removing unncessary files from this directory."
sleep 1
echo "Please keep all remaining files within this directory for system stability."
sleep 1
echo
echo "Cleaning up installation..."
sleep 5
sudo rm -rf ~/go/
chmod +x ~/.local/share/calos/bin/calos-pkg-list
rm ~/.local/share/calos/bin/calos-tui-install
cp ~/.local/share/calos/applications/hidden/* ~/.local/share/applications/
cp ~/.local/share/calos/applications/nvim.desktop ~/.local/share/applications/
cp ~/.local/share/calos/applications/limine-snapper-restore.desktop ~/.local/share/applications/
rm -rf ~/.local/share/calos/applications
rm -rf ~/.local/share/calos/install
rm -rf ~/.local/share/calos/config
rm -rf ~/.local/share/calos/.git

sudo pacman -Rns maven --noconfirm
#sudo pacman -Rns rust --noconfirm
sudo updatedb
sleep 2
clear

cat ~/.local/share/calos/install/logo.txt | tte expand
echo
echo
echo "Installation completed. Reboot to access system."
echo "Make sure to read through your configuration files to familarize yourself with operations!"
echo "Please check the configuration files under ~/.config/hypr especially. This is how you interact with your system."
echo
