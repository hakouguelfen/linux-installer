#!/usr/bin/env bash

sudo pacman -S zsh alacritty lsd bat zoxide fzf neovim rofi vlc zsh-syntax-highlighting zsh-autosuggestions zip unzip ripgrep fd emacs-nativecmop most zathura zathura-pdf-poppler github-cli dunst libsecret gnome-keyring mpv udiskie nemo fuzzel hyprpaper hyprland xdg-desktop-portal-hyprland waybar brightnessctl ly qbittorrent polkit-kde-agent qt5-wayland qt6-wayland discord htop neofetch flameshot
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
paru -S colloid-gtk-theme-git colloid-icon-theme-git ttf-amiri
sudo pacman -S ttf-fira-codettf-firacode-nerd 

#install some apps
paru -S brave-bin nuclear-player-bin nomacs nwg-look-bin

########################################
########### clone my dotfiles ##########
########################################
git clone -b main https://github.com/hakouklvn/dotfiles
cp -r dotfiles/.config/* .config/
cp dotfiles/.zshrc ~/
cp dotfiles/.p10k.zsh ~/

# configure zsh
paru -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

# configure keyrings for mailspring
# dbus-update-activation-environment --systemd DISPLAY
# eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
# export SSH_AUTH_SOCK

## install fonts & thmes
#paru -S catppuccin-gtk-theme-mocha sddm-catppuccin-git
# sudo systemctl enable sddm
# echo '
# [Theme]
# Current=catppuccin
# ' >> sudo /usr/lib/sddm/sddm.conf.d/default.conf
