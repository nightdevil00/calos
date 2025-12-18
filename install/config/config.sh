#!/bin/bash

# Copy over all config files to ~ prior to deletion
mkdir -p ~/.config
cp -R ~/.local/share/calos/config/* ~/.config/

# Use custom .bashrc
mv ~/.local/share/calos/install/bashrc ~/.bashrc
