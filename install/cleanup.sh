chmod +x ~/.local/share/calos/bin/calos-pkg-list
chmod +x ~/.local/share/calos/bin/calos-list-keybindings
chmod +x ~/.local/share/calos/bin/calos-toggle-gamemode
rm ~/.local/share/calos/bin/calos-tui-install
cp ~/.local/share/calos/applications/hidden/* ~/.local/share/applications/
cp ~/.local/share/calos/applications/nvim.desktop ~/.local/share/applications/
rm -rf ~/.local/share/calos/applications
rm -rf ~/.local/share/calos/config
rm -rf ~/.local/share/calos/.git
sudo updatedb
clear
cat ~/.local/share/calos/install/logo-complete.txt | tte --xterm-colors --frame-rate 60 middleout
echo
rm -rf ~/.local/share/calos/install
rm ~/.local/share/calos/README.md
