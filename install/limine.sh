#!/bin/bash

# Removing alternative limine.conf location for the sake of consistency/auto-updates
sudo rm /boot/EFI/limine/limine.conf

sudo tee /boot/limine.conf <<EOF >/dev/null
### Read more at config document: https://github.com/limine-bootloader/limine/blob/trunk/CONFIG.md
timeout: 3
verbose: no
default_entry: 2
wallpaper: boot():/boot.jpg
 
EOF

yay -S --noconfirm --needed limine-mkinitcpio-hook
sudo limine-update
