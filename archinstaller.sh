#!/usr/bin/env bash

sudo pacman -S zsh alacritty lsd bat zoxide fzf neovim zsh-syntax-highlighting zsh-autosuggestions zip unzip ripgrep fd emacs-nativecomp most zathura zathura-pdf-poppler dunst mpv pcmanfm-gtk3 brightnessctl ly qbittorrent htop stow imv vivid flameshot wget
#sudo pacman -S xdg-desktop-portal-hyprland github-cli discord libsecret udiskie polkit-kde-agent qt5-wayland qt6-wayland fuzzel hyprpaper hyprland waybar grim slurp nwg-look 
sudo pacman -S --needed hsetroot

########################################
########### Install paru ###############
########################################
#git clone https://aur.archlinux.org/paru.git paru && cd paru || exit
#makepkg -si
#cd ..
#rm -rf paru

########################################
########### Install doom ###############
########################################
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

########################################
######### install fonts  ###############
########################################
mkdir .fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip .fonts/
cd .fonts
unzip FiraCode.zip
rm -rf FiraCode.zip
cd

########################################
######### install themes  ##############
########################################
git clone https://github.com/vinceliuice/Colloid-gtk-theme
git clone https://github.com/vinceliuice/Colloid-icon-theme
sh Colloid-gtk-theme/install.sh -t grey -c dark -l --tweaks nord 
sh Colloid-icon-theme/install.sh -s nord -t grey

rm -rf Colloid-gtk-theme
rm -rf Colloid-icon-theme

########################################
########### clone my dotfiles ##########
########################################
git clone https://github.com/hakouklvn/wayland_dotfiles dotfiles
stow -t ~ --ignore=README.md .
git clone https://github.com/hakouklvn/scripts .local/bin/scripts
sudo git clone https://github.com/hakouklvn/wallpaper /usr/share/wallpaper

########################################
########### change bash shell ##########
########################################
chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

