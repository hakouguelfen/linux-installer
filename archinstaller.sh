#!/usr/bin/env bash

sudo pacman -S base-devel xorg picom nitrogen zsh qtile alacritty lsd bat zoxide fzf neovim vivid  mypy python-pip python-iwlib rofi vlc transmission-gtk zsh-syntax-highlighting zsh-autosuggestions alsa-utils light zip unzip ripgrep fd emacs most zathura zathura-pdf-poppler conky github-cli dunst clang ninja sddm qbittorent python-yaml discord libsecret gnome-keyring mpv
sudo pacman -S --needed hsetroot

## install paru
git clone https://aur.archlinux.org/paru.git paru && cd paru || exit
makepkg -si
cd ..
rm -rf paru

# install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# configure keyrings for mailspring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# install fonts & thmes
paru -S ttf-meslo-nerd-font-powerlevel10k nvim-packer-git colloid-gtk-theme-git colloid-icon-theme-git catppuccin-gtk-theme-mocha sddm-catppuccin-git ttf-amiri
sudo pacman -S ttf-fira-code ttf-font-awesome

sudo systemctl enable sddm
echo '
[Theme]
Current=catppuccin
' >> sudo /usr/lib/sddm/sddm.conf.d/default.conf

#install some apps
paru -S brave-bin spotify flameshot nomacs htop neofetch lxappearance qt5ct nm-connection-editor pcmanfm lxsession mailspring insomnia-bin

# configure zsh
paru -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

chsh -s /bin/zsh root
chsh -s /bin/zsh "$USER"

sudo touch /etc/X11/xorg.conf.d/00-keyboard.conf
sudo touch /etc/X11/xorg.conf.d/40-libinput.conf

echo '
Section "InputClass"
       Identifier "system-keyboard"
       MatchIsKeyboard "on"
       Option "XkbLayout" "fr"
       Option "XkbModel" "pc105"
       Option "XkbOptions" "terminate:ctrl_alt_bksp"
EndSection' >> sudo /etc/X11/xorg.conf.d/00-keyboard.conf

echo '
Section "InputClass"
   Identifier "libinput touchpad catchall"
   Driver "libinput"
   Option "Tapping" "on"
EndSection' >> sudo /etc/X11/xorg.conf.d/40-libinput.conf
