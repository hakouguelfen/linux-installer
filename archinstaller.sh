#!/usr/bin/env bash

sudo pacman -S zsh alacritty lsd bat zoxide fzf neovim zsh-syntax-highlighting zsh-autosuggestions zip unzip ripgrep fd emacs-nativecmop most zathura zathura-pdf-poppler dunst mpv pcmanfm-gtk3 fuzzel hyprpaper hyprland waybar brightnessctl ly qbittorrent htop grim slurp stow imv mat2 onionshare nwg-look thunderbird calibre
sudo pacman -S xdg-desktop-portal-hyprland github-cli discord libsecret udiskie polkit-kde-agent qt5-wayland qt6-wayland
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
######### install fonts  ###############
########################################
sudo pacman -S ttf-fira-codettf-firacode-nerd 

########################################
######### install themes  ##############
########################################
git clone https://github.com/vinceliuice/Colloid-gtk-theme
git clone https://github.com/vinceliuice/Colloid-icon-theme
sh Colloid-gtk-theme/install.sh -t grey -c dark -l --tweaks nord 
sh Colloid-icon-theme/install.sh -s nord -t grey

rm -rf Colloid-gtk-theme
rm -rf Colloid-icon-theme

#install some apps
paru -S librewolf-bin nuclear-player-bin spotify-bin

########################################
########### clone my dotfiles ##########
########################################
git clone https://github.com/hakouklvn/wayland_dotfiles dotfiles
stow dotfiles/*
git clone https://github.com/hakouklvn/scripts .local/bin/
git clone https://github.com/hakouklvn/wallpaper /usr/share/

########################################
########### change bash shell ##########
########################################
chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

