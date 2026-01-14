#!/bin/bash
set -eE

export PATH="$HOME/.local/share/calos/bin:$PATH"
CALOS_INSTALL=~/.local/share/calos/install

# Install Initialization

sudo pacman -S --noconfirm --needed gum

clear
gum style --border normal --border-foreground 212 --padding="1 3" "Welcome to $(gum style --bold --foreground 212 'calOS')!" "This script will turn your base Arch Linux install into a minimal, yet functional, Hyprland setup." "The installer will install/enable Chaotic-AUR as well as paru to function as your AUR helper." "Make sure you are running this installation script on a $(gum style --foreground 212 'fresh Arch Linux installation')!"
echo
sleep 6
gum confirm "Proceed with Install?" && gum spin -s line --title="Installation starting..." -- sleep 2 || exit 1

# Scripts for error reporting and repository edits

source $CALOS_INSTALL/preinstall/errors.sh
source $CALOS_INSTALL/preinstall/repositories.sh
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed paru
clear

# System critical AUR packages

gum style --border normal --border-foreground 212 --padding="1 3" "Chaotic-AUR repository synced and paru has been installed." "The installer will now begin downloading and building AUR packages required for basic system functionality." "This is the most time-consuming portion of the install. Time spent will vary based on your hardware."
sleep 5
echo
gum spin -s line --title="Resuming install..." -- sleep 4
sudo pacman -S --noconfirm --needed yaru-icon-theme clipse
paru -S --noconfirm --needed python-terminaltexteffects rose-pine-hyprcursor elephant elephant-desktopapplications elephant-menus elephant-calc walker-bin --skipreview --removemake --cleanafter
clear

# Main packages, configuration and scripts

gum style --border normal --border-foreground 212 --padding="1 3" "AUR system packages built and installed successfully! Build files will be cleansed post-installation." "The installer will now download/install all required packages and link required configuration files."
echo
sleep 4
gum spin -s line --title="Resuming install..." -- sleep 4
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

gum style --border normal --border-foreground 212 --padding="1 3" "The installer will now prompt you to select your GPU architecture." "If an AMD is selected the installer will install and enable rocm support for complete sytem monitor integration." "Choosing NVIDIA will run the NVIDIA installation script, which will then scan your hardware and download required dependencies/headers."
echo
sleep 2
GPU=$(gum choose --item.foreground 250 "AMD" "NVIDIA")
[[ "$GPU" == "AMD" ]] && gum spin -s line --title="AMD selected! Installing dependencies..." -- sleep 3 && sudo pacman -S --noconfirm --needed rocm-smi-lib || source $CALOS_INSTALL/nvidia.sh
clear

# Limine bootloader setup

gum style --border normal --border-foreground 212 --padding="1 3" "The installer will now check which bootloader you have installed." "The default recommended bootloader is Limine, however, other bootloaders are fully supported." "If Limine is detected the installer will enable various features, such as automated mkinitcpio/dual-booting."
sleep 6
echo
gum spin -s line --title="Resuming install..." -- sleep 4
source $CALOS_INSTALL/limine.sh
sudo cp ~/.local/share/calos/install/bash_profile ~/.bash_profile
clear


# Miscellaneous scripting

gum style --border normal --border-foreground 212 --padding="1 3" "The installer will now apply various miscellaneous fixes/scripts to your architecture." "These include a custom login/boot script, systemctl services and enhancing system functionality."
sleep 4
echo
gum spin -s line --title="Resuming install..." -- sleep 4
sudo cp ~/.local/share/calos/install/greet-config.toml /etc/greetd/config.toml
sudo cp ~/.local/share/calos/install/motd /etc/motd
sudo cp ~/.local/share/calos/install/issue /etc/issue
echo "$USER ALL=(ALL:ALL) NOPASSWD: /usr/bin/systemctl start bootmsg.service" | sudo tee "/etc/sudoers.d/no-bootmsg-prompt"
sudo cp ~/.local/share/calos/install/bootmsg.service /etc/systemd/system/bootmsg.service
source $CALOS_INSTALL/misc.sh
xdg-settings set default-web-browser firefox.desktop
echo
systemctl --user enable --now hyprpolkitagent.service
sudo chmod 666 /dev/uinput
sudo pacman -Rdd greetd-agreety --noconfirm
sudo systemctl enable greetd.service
elephant service enable
systemctl --user enable --now elephant.service
clear

# AUR helper

gum style --border normal --border-foreground 212 --padding="1 3" "Please specify which AUR helper you would like to utilize on your system." "By default the installer ships with and utilizes Paru." "Paru is relatively faster than yay with built-in PKGBUILD viewing in terminal." "If you would still like to switch back to yay, please specify below."
echo
sleep 4
HELPER=$(gum choose --item.foreground 250 "Paru" "yay")
[[ "$HELPER" == "yay" ]] && gum spin -s line --title="paru will now be replaced with yay..." -- sleep 3 && sudo pacman -S --noconfirm --needed yay && sudo pacman -Rns paru --noconfirm || gum spin -s line --title="paru will remain as your AUR helper. Resuming install..." -- sleep 4

# Installation Cleanup

gum style --border normal --border-foreground 212 --padding="1 3" "The installer will now begin removing unnecessary files created during install." "Please keep all remaining files in $(gum style --foreground 212 '~/.local/share/calos') for system stability."
sleep 3
echo
gum spin -s line --title="Cleaning up installation..." -- sleep 4
chmod +x ~/.local/share/calos/bin/calos-pkg-list
chmod +x ~/.local/share/calos/bin/calos-list-keybindings
rm ~/.local/share/calos/bin/calos-tui-install
cp ~/.local/share/calos/applications/hidden/* ~/.local/share/applications/
cp ~/.local/share/calos/applications/nvim.desktop ~/.local/share/applications/
rm -rf ~/.local/share/calos/applications
rm -rf ~/.local/share/calos/config
rm -rf ~/.local/share/calos/.git
sudo updatedb
clear
cat ~/.local/share/calos/install/logo-complete.txt | tte --xterm-colors --frame-rate 60 middleout
rm -rf ~/.local/share/calos/install
rm ~/.local/share/calos/README.md

# Installation Completion and Optional Steam Install

gum style --border normal --border-foreground 212 --padding="1 3" "$(gum style --bold --foreground 212 'Installation complete'), reboot to access system. Your username will be remembered by the greeter after your first login." "Make sure to read through your configuration files to familarize yourself with system operations., especially those in $(gum style --italic '~/.config/hypr')." "It is heavily recommended to configure your $(gum style --italic '~/.config/hypr/monitors.conf') file in order to set a proper resolution and refresh rate." "Lastly, if you would like to install Steam, please follow the prompts below. Multilib repositories have already been enabled."
sleep 8
echo
echo
gum confirm "Install Steam?" && gum spin -s line --title="Initializing Steam installation script..." -- sleep 4 && source ./steam.sh || echo "Steam will not be installed."
echo
echo
sleep 2
gum confirm "Would you like to reboot to BIOS?" && systemctl reboot --firmware-setup
