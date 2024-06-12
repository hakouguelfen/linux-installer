#!/usr/bin/env bash

sudo apt install zsh alacritty lsd bat zoxide fzf neovim zsh-syntax-highlighting zsh-autosuggestions zip unzip ripgrep emacs most zathura zathura-pdf-poppler dunst mpv pcmanfm brightnessctl htop stow imv vivid flameshot wget tmux pipewire
#sudo pacman -S xdg-desktop-portal-hyprland github-cli discord libsecret udiskie polkit-kde-agent qt5-wayland qt6-wayland fuzzel hyprpaper hyprland waybar grim slurp nwg-look 
#sudo pacman -S --needed hsetroot

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
########### Install tmux ###############
########################################
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

########################################
######### install fonts  ###############
########################################
mkdir .fonts && cd .fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip 
unzip FiraCode.zip
rm -rf FiraCode.zip
cd

########################################
######### install themes  ##############
########################################
git clone https://github.com/vinceliuice/Colloid-gtk-theme
git clone https://github.com/vinceliuice/Colloid-icon-theme
bash Colloid-gtk-theme/install.sh -t grey -c dark -l --tweaks nord 
bash Colloid-icon-theme/install.sh -s nord -t grey

rm -rf Colloid-gtk-theme
rm -rf Colloid-icon-theme

########################################
########### clone my dotfiles ##########
########################################
git clone https://github.com/hakouklvn/wayland_dotfiles dotfiles
cd dotfiles
stow -t ~ --ignore=README.md .
cd
#git clone https://github.com/hakouklvn/scripts .local/bin/scripts
#sudo git clone https://github.com/hakouklvn/wallpaper /usr/share/wallpaper

########################################
########### change bash shell ##########
########################################
chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

# change keyboard layout to azerty
echo '
Section "InputClass"
       Identifier "system-keyboard"
       MatchIsKeyboard "on"
       Option "XkbLayout" "fr"
       Option "XkbModel" "pc105"
       Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection' > sudo /etc/X11/xorg.conf.d/00-keyboard.conf

## enable touchpad 
echo '
Section "InputClass"
   Identifier "libinput touchpad catchall"
   Driver "libinput"
   Option "Tapping" "on"
EndSection' > sudo /etc/X11/xorg.conf.d/40-libinput.conf
