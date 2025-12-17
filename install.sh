#!/bin/bash
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

# Install Initialization

clear
sleep 1
echo "Welcome to calOS! A few words:"
echo
sleep 1
echo "Paru will be installed by default alongside the Chaotic-AUR repository. If you would like to remove Chaotic-AUR after the installation, proceed to /etc/pacman.conf"
echo "and remove the final two lines. The installer will also enable the multilib repositories, this helps with NVIDIA GPU detection and Steam installation."
sleep 3
echo
echo "Installation starting..."
sleep 5

# Scripts for error reporting and repository edits

source $CALOS_INSTALL/preinstall/errors.sh
source $CALOS_INSTALL/preinstall/repositories.sh
sudo pacman -S --needed base-devel
sudo pacman -S --noconfirm --needed paru
clear

# System critical AUR packages

echo "Chaotic-AUR repository synced and paru has been installed."
sleep 3
echo
echo "The installer will now begin installing AUR programs required for basic system functionality."
sleep 3
sudo pacman -S --noconfirm --needed yaru-icon-theme clipse
paru -S --noconfirm --needed python-terminaltexteffects rose-pine-hyprcursor gpu-screen-recorder elephant elephant-desktopapplications elephant-menus elephant-calc walker --skipreview --removemake --cleanafter
clear

# Main packages, configuration and scripts 

echo "AUR system packages built and installed successfully! Build files will be cleaned post-installation."
sleep 3
echo
echo "Main packages and configuration files will now be installed..."
sleep 3
source $CALOS_INSTALL/packages.sh
source $CALOS_INSTALL/lazyvim.sh
source $CALOS_INSTALL/config/config.sh
source $CALOS_INSTALL/config/theme.sh
source $CALOS_INSTALL/config/branding.sh
calos-tui-install "Dust" "bash -c 'dust -r; read -n 1 -s'" float https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/qdirstat.png
mkdir -p ~/.local/share/fonts
fc-cache
clear

# NVIDIA checks, AMD fixes

echo "Checking hardware for Nvidia GPU..."
echo
sleep 1
echo "Installer will download/update all required configuration file/packages if found."
sleep 1
echo "It is critical that you have multilib repositories enabled. If you are running the installer this is enabled by default."
sleep 1
echo "If an AMD gpu is detected the installation script will instead enable rocm support for full system integration."
sleep 6
source $CALOS_INSTALL/nvidia.sh
sleep 2
clear

# Limine bootloader setup

echo "Limine bootloader configuration will now be installed."
sleep 1
echo "By default, snapper services are not configured but calOS allows for full Snapshot integration with the bootloader."
echo "Refer to limine-snapper-sync in order to complete this setup yourself."
sleep 3
echo
echo "Resuming Installation..."
sleep 5
source $CALOS_INSTALL/limine.sh
sudo cp ~/.local/share/calos/install/boot.jpg /boot/boot.jpg
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile
sleep 2
clear

# Login and boot message service

echo "Creating login service..."
sleep 2
sudo cp ~/.local/share/calos/install/greet-config.toml /etc/greetd/config.toml
sudo cp ~/.local/share/calos/install/motd /etc/motd
echo "$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/systemctl start bootmsg.service" | sudo tee "/etc/sudoers.d/no-bootmsg-prompt"
sudo cp ~/.local/share/calos/install/bootmsg.service /etc/systemd/system/bootmsg.service
echo
echo
echo "Boot message service added and enabled. This is located in your home directory's .bashrc file. Configure it as needed."
sleep 5
clear

# Systemctl services

echo "Enabling system services for walker, elephant, waybar and applying miscellaneous fixes..."
sleep 3
source $CALOS_INSTALL/misc.sh
xdg-settings set default-web-browser firefox.desktop
echo
systemctl --user enable --now hyprpolkitagent.service
sudo chmod 666 /dev/uinput
sudo pacman -Rdd greetd-agreety --noconfirm
sudo systemctl enable greetd.service
elephant service enable
systemctl --user enable --now elephant.service
systemctl --user enable waybar.service
clear

# Installation Cleanup

echo "The installer will now begin removing unnecessary files from this directory."
sleep 1
echo "Please keep all remaining files within ~/.local/share/calos (present directory) for system stability."
sleep 2
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
rm -rf ~/.local/share/calos/config
rm -rf ~/.local/share/calos/.git
sudo pacman -Rns maven --noconfirm
sudo updatedb
sleep 2
clear
cat ~/.local/share/calos/install/logo.txt | tte expand
rm -rf ~/.local/share/calos/install
rm ~/.local/share/calos/blank.txt
rm ~/.local/share/calos/icon.txt
rm ~/.local/share/calos/logo.txt
rm ~/.local/share/calos/README.md

# Install Complete

echo
echo
echo "Installation completed, reboot to access system. Your username will be remembered by the greeter after your first login."
echo "Make sure to read through your configuration files to familarize yourself with operations!"
echo "Please check the configuration files under ~/.config/hypr especially. This is how you interact with your system."
echo
sleep 3
echo "It is heavily recommended to configure your ~/.config/hypr/monitors.conf file in order to set a proper resolution and refresh rate."
echo "By default your resolution should be correct but your refresh rate is locked to 60hz. Refer to the file in question for examples." 
echo "Your OS comes with a pre-installed neovim/lazyvim configuration that can be called using 'n' or 'svim' (for sudo edits)."
echo
