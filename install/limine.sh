#!/bin/bash

# Check for alternative limine configuration files and if found, remove them

if test -f /boot/limine/limine.conf; then
sudo rm /boot/limine/limine.conf
else
echo "Configuration file not found, checking alternative locations..."
fi

if test -f /boot/EFI/limine/limine.conf; then
sudo rm /boot/EFI/limine/limine.conf
else
echo "No alternative limine configurations found, resuming install..."
fi

sudo tee /boot/limine.conf <<EOF >/dev/null
### Read more at config document: https://github.com/limine-bootloader/limine/blob/trunk/CONFIG.md
timeout: 3
verbose: no
default_entry: 2
wallpaper: boot():/boot.jpg
 
EOF

paru -S --noconfirm --needed limine-mkinitcpio-hook --skipreview
sudo limine-update
