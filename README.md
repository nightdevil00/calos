<p align="center">
<img width="697" height="564" alt="image" src="https://github.com/user-attachments/assets/e8a122c1-2a36-4270-ae76-c4e85590ee52" />
</p>


# calOS Hyprland Starter
CalOS is a pre-configured, desktop-friendly, Arch+Hyprland setup that strives to be both feature-rich, yet minimalist; a blank template that the user can build on top of (and it also looks really cool). CalOS started as a fork of Omarchy when it first released, using the theme engine it shipped with alongside Walker's dmenu. Since then Omarchy has grown more and more bloated, while CalOS has done the opposite (less than 575 packages on a complete install)! **Note: This is only for experienced Arch Linux users. You must do all system maintenence on your own.** This OS is basically vanilla Arch Linux with Hyprland + themes. **calOS (and its installer) has been tested on both AMD (9070XT) and NVIDIA (3070) hardware. It should work on your system; if not, create an issue. Refer to /install/nvidia.sh for support.**

CalOS is comprised of 3 main 'parts'. The first is Arch+Hyprland, with a hefty amount of intelligent, yet configurable, keybinds/defaults. Walker interacts with your system through launching applications and its extensive dmenu support. A customized Mechabar (waybar) helps monitor your system as well interact with your hyprland configuration. As aforementioned, this is primarily a desktop-friendly configuration. Features such as battery monitoring, lockscreens and power profiles (performance all the way) are not present by default. Feel free to add them if you want, it's your PC after all.

tl;dr its dotfiles baby
<p align="center">
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/bb2a9d95-0ad6-422b-a9ef-7b96224bf1fd" />
</p>

### Who is calOS for?

CalOS is directed to primarily desktop users who have some familiarity with Arch Linux and wanted to try their hand at Hyprland. It ships with defaults that are already very gaming-friendly (Steam especially) with a high amount of configurability. Productivity is not the main goal, functionality is. If you use your desktop PC as a glorified web browser, gaming machine or social outlet, calOS is for you. You can always add on whatever else you like, but at its base default configuration, calOS is simply a really nice Hyprland skin designed to be as bare as possible so you can add your own magic. **This is essentially a starter kit for your foray into Hyprland.**

## Overview

### System

* A custom hyprland.conf file with numerous keybinds and configurations.
  - Most keybinds should just *make sense*, such as Super + B launching your Browser. For a full list refer to the keybindings.conf file in ~/.config/hypr, or use `SUPER + K` to bring up a custom dmenu showcasing all keybindings currently active. Important bindings are:
  - Super + Escape to bring up your Walker dmenu for system features (toggle system settings, power menu, app launcher).
  - Super + Space shows your application launcher.
  - Super + Enter for your terminal (Alacritty).
  - Super + S for System Monitoring (btop++).
  - Super + N for Neovim.
  - Super + Y for Yazi (file manager).
  - Super + Q to close the active window.
* `SUPER + CTRL` brings up all of your system management keybinds. The binds below assume you are already holding down SUPER + CTRL.
```
 + L enables up your screensaver.
 + N will toggle hyprsunset (bluelight filter go to sleep).
 + W will toggle waybar on/off.
 + C shows your clipboard history (clipse).
 + B brings up the Bluetooth menu (bluetui).
 + S launches walker's dmenu, specifically for power options.
 + I shows internet settings (impala).
 + T is your theme menu. Refer to the style section below.
```
* `SUPER + SHIFT` are the browser-based keybinds. Refer to the keybindings.conf file in your ~/.config/hypr folder to easily change them. By default they open up popular webpages.
* Gaming friendly. Look into the `games.conf` file in your hyprland config folder to see all features. Includes a gaming submap bound to `Super + CTRL + G`, a special gaming workspace mode and support for steam games.
* A highly configurable systemd service that launches on your **first terminal only** each login. Want to run certain startup scripts/display your cringe-inducing fastfetch configuration on the first terminal? Now you can! Once the first terminal launches a service begins that prevents it from launching again afterwards. 


### Style

Regardless of how you feel about Omarchy, most of us can agree that it does look pretty. CalOS builds off of the themes of Omarchy and extends them into multiple facets of the operating system. Many, many, many (autistic) hours were spent tweaking each theme CalOS ships with to compliment the entire OS. Your waybar, audio visualizer, terminal and system monitoring tools will all change based on the theme you're feeling. This took so long you son of a bitch you better use this feature.

<p align="center">
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/9bb5831b-fa81-4821-8e5d-cc677223b05d" />
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/01baaed9-be8f-40aa-98ec-8974084dceee" />
<img width="3440" height="1440" alt="image" src="https://github.com/user-attachments/assets/55714cf8-73b5-4179-ab6d-2ce10fe400b1" />
</p>

This is a pretty decent spot to talk about how to interact with the operating system as a whole.
  - Workspace 1 is always active, even if it's blank (this allows you to scroll through it even if there are no windows currently active).
  - Workspace 2 deals with system interaction. Your btop++ lives here, as does an interactive terminal. CAVA (your audio visualizer) and cmus (tui-based music player) are here.
  - Workspace 3 is your gaming stuff. Discord. Steam.
  - Workspace 4 and 5 are empty by default. Unlike workspace 1, these are de-activated until you switch to them.
  - User SUPER + 1, 2, 3, etc. to switch to a specific workspace. Hold SUPER + SHIFT + [NUMBER] to move the current active window to [NUMBER] workspace.

### Defaults

Trying to distance itself from various *opinionated* setups, calOS ships with as few defaults as possible. These include: Firefox (web browser), Alacritty (terminal), Steam (if chosen by the installer), Neovim (with customized lazygit) and Yazi (file manager).
* calOS utilizes sensible, lightweight defaults, with as little dependencies as possible. These include pqiv (image viewer, full yazi compatability), clipse (clipboard history), zoxide (`cd` upgrade), Pinta (simple image editor), cmus (terminal-based music player) and various TUI applications to manage system settings (bluetui/impala).
* **Open your system settings (SUPER + ESCAPE) and navigate to System -> Packages to see what is installed.** Remove whatever you dislike from there.
* There is a prompt at the very end of the install that asks you if you would like to install Steam. As the installer already enables multilib repositories it is recommended to do so (only if you want Steam, of course). 

# Installation and Configuration

## How 2 Install

**You must have a fresh Arch install going into this.** Feel free to use any settings you want; from disk encryption to file system. The only required settings for the install script to work properly is to **use Limine as your default bootloader** and **set root and create a user** (which you should be doing anyway, you dummy). **Pipewire must be used.** Why would you use pulseaudio anyways...

```
sudo pacman -S git
```
Install git to clone the repository into the specified directory.

Create your directories:
```
mkdir -pv ~/.local/share
cd ~/.local/share
```

From there, clone this repository:

```
git clone https://github.com/criticalart/calos
```
Then `cd` into /calos/ and run `./install.sh.` Wow crazy. 

## Post Installation

* It is imperative that you familiarize yourself with your new system. One of the best ways is to look through the various configuration files.
* If you are a lazy sack of shit just read through the ~/.config/hypr configuration files as those are what you use to interact with your system.

## Why Paru?

* Why do you care so much??? Paru is significantly faster than yay as well as allowing you to view package builds in your terminal. Yay is much easier to type out on the terminal, sure, but feature wise paru is just better. Stop being scared of new things and just try it. You shouldn't even be downloading things from the AUR you dirty person. Actually it broke while writing this but uh it works now I guess.
