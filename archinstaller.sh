#!/usr/bin/env bash

sudo pacman -S zsh alacritty lsd bat zoxide fzf neovim rofi vlc zsh-syntax-highlighting zsh-autosuggestions zip unzip ripgrep fd emacs-nativecmop most zathura zathura-pdf-poppler github-cli dunst libsecret gnome-keyring mpv udiskie nautilus fuzzel hyprpaper hyprland xdg-desktop-portal-hyprland waybar brightnessctl ly qbittorrent polkit-kde-agent qt5-wayland qt6-wayland discord htop neofetch flameshot stow imv
sudo pacman -S --needed hsetroot

########################################
########### Install paru ###############
########################################
git clone https://aur.archlinux.org/paru.git paru && cd paru || exit
makepkg -si
cd ..
rm -rf paru

########################################
########### Install doom ###############
########################################
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

########################################
######### install fonts & thmes ########
########################################
paru -S colloid-gtk-theme-git colloid-icon-theme-git
sudo pacman -S ttf-fira-codettf-firacode-nerd 

#install some apps
paru -S librewolf-bin nuclear-player-bin imv nwg-look-bin

########################################
########### clone my dotfiles ##########
########################################
git clone https://github.com/hakouklvn/wayland_dotfiles
stow wayland_dotfiles/*  
git clone https://github.com/hakouklvn/scripts .local/bin/
git clone https://github.com/hakouklvn/wallpaper /usr/share/

########################################
########### change bash shell ##########
########################################
chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

