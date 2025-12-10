# UNDER CONSTRUCTION UNTIL 2.0

# calOS
CalOS is a pre-configured Arch+Hyprland setup that strives to be both feature-rich, yet minimalist; a blank template that the user can build on top of. CalOS started as a fork of Omarchy when it first released, using the theme engine it shipped with alongside Walker's dmenu. Since then Omarchy has grown more and more bloated, while CalOS has done the opposite (only 600+ packages on a complete install)! **Note: This is only for experienced Arch Linux users. You must do all system maintenence on your own.**

tl;dr its dotfiles baby

## Overview

### System

* A custom hyprland.conf file with numerous keybinds and configurations.
* `SUPER + CTRL` brings up all of your system-based keybinds. This includes a clipboard manager (clipse), power menu, screensaver, internet/bluetooth/waybar management and much more.
* `SUPER + SHIFT` are the browser-based keybinds. Examples include 


### Style

* Changed default theme on first launch. Make it feel more Hyprland-y.
* Removed Omarchy logo and replaced with Arch logo in almost every instance. Felt kind of weird doing this but ultimately this is an Arch distro first and foremost.
* Added more themes to the install. Parsed every theme to make sure it was uniform with the rest of the system; e.g. blueridge would overwrite your font when you switched to it, now it doesn't. Also removed super bright themes because???
* **Made a custom starship bash prompt for every theme included in the install**. This took HOURS. A different starship prompt. For every theme. I hate being autistic.
* Animations added for workspaces and specialWorkspaceIn/Out.
* Changed default cursor to look more _uhh_ not boring.
* Cool Limine background #wow #whoa

### Usability

* Added support for specialWorkspaces for gaming. Hit SUPER, G to easily switch between your currently running game and workspace(s). Will work alongside gamescope. Check hyprland.conf and autostart.conf for more information.
* Changed layering for waybar so it's more compatible for gaming across the board.
* Tweaked various settings and defaults. Feel free to parse them yourself, one of Omarchy's strengths is how configurable it is so if I added something it doesn't really matter, just change it.
* Changed firefox to the default browser. Get wrecked, Google.
* Some cool defaults in autostart.conf, including timers for launching applications in a specific order. Super helpful for layouts. Additional package launches are commented out for your convenience.
* Moved around the main menu. Config is now front and center for easy access to your configuration files. Removed redundant menu items.
* A ton of other shit I just don't feel like going over.

# Installation and Configuration

## How 2 Install

**You must have a fresh Arch install going into this.** Feel free to use any settings you want; from disk encryption to file system. The only required settings for the install script to work properly is to **use Limine as your default bootloader** and **set root and create a user** (which you should be doing anyway).

```
sudo pacman -S git nano
```
Install git to clone the repository and nano to edit a few configuration files below.

Create your directories:
```
mkdir ~/.local
mkdir ~/.local/share
cd ~/.local/share
```

From there, clone this repository:

```
git clone https://github.com/criticalart/calos
```
Then cd into /calos/ and ./install.sh. Wow crazy. **Don't do it yet though**, there are a few things you have to configure below:

## Required Configuration

**The following settings must be changed for the user experience, or whatever.**

* Under /calos/config/hypr **make sure to change the monitors.conf file** to match your respective resolution/refresh rate.
* I always felt that Hyprland by default was a bit too sensitive with the mouse, so I lowered the sensitivity to -0.5. Simply comment this line our or change it to your preference.
* That's all for the required configurations. I encourage you to do your own research and edit this to your heart's content.


That's all there is to it. Omarchy is an absolutely incredible tool but it's a bit too opinionated for me so I made calOS. Try it out and make your own fork/OS afterwards. Thank you DHH/basecamp for documenting everything as well as you did. Made it super easy to make this.
