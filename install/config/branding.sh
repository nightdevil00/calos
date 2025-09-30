#!/bin/bash

# Allow the user to change the branding for fastfetch and screensaver
mkdir -p ~/.config/calos/branding
cp ~/.local/share/calos/icon.txt ~/.config/calos/branding/about.txt
cp ~/.local/share/calos/logo.txt ~/.config/calos/branding/screensaver.txt
cp ~/.local/share/calos/blank.txt ~/.config/calos/branding/blank.txt
