#!/bin/bash

# Allow the user to change the branding for fastfetch and screensaver
mkdir -p ~/.config/calos/branding
cp ~/.local/share/calos/install/icon.txt ~/.config/calos/branding/about.txt
cp ~/.local/share/calos/install/logo.txt ~/.config/calos/branding/screensaver.txt
cp ~/.local/share/calos/install/blank.txt ~/.config/calos/branding/blank.txt
