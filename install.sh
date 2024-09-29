#!/usr/bin/env bash

OS_NAME=$(awk -F= '/^ID=/ {print $2}' /etc/os-release)
COMMON_PACKAGES="alacritty zsh neovim zip unzip most zathura zathura-pdf-poppler zathura-pdf-mupdf pcmanfm dunst mpv htop stow imv wget tmux pipewire brightnessctl ripgrep lsd bat zoxide fzf zsh-syntax-highlighting zsh-autosuggestions flameshot udiskie foliate"
NOT_COMMON_PACKAGES="vivid github-cli"
WAYLAND_PACKAGES="xdg-desktop-portal-hyprland libsecret polkit-kde-agent qt5-wayland qt6-wayland fuzzel hyprpaper hyprland waybar grim slurp nwg-look"

main(){
    case "$OS_NAME" in
        fedora)
            fedoraInstaller
            ;;
        arch)
            archInstaller
            ;;
        debian)
            debianInstaller
            ;;
        *)
            echo "Unsupported OS: $OS_NAME"
            exit 1
            ;;
    esac

    ########################################
    ######## change to zsh shell ###########
    ########################################
    chsh -s /bin/zsh "$USER"

    ########################################
    ######### install fonts  ###############
    ########################################
    mkdir .fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip .fonts/
    unzip .fonts/FiraCode.zip
    rm -rf .fonts/FiraCode.zip

    ########################################
    ######## install themes  ###############
    ########################################
    git clone https://github.com/vinceliuice/Colloid-gtk-theme
    git clone https://github.com/vinceliuice/Colloid-icon-theme
    bash Colloid-gtk-theme/install.sh -t grey -c dark -l --tweaks nord
    bash Colloid-icon-theme/install.sh -s nord -t grey

    rm -rf Colloid-gtk-theme
    rm -rf Colloid-icon-theme

    ########################################
    ######## clone my dotfiles #############
    ########################################
    git clone https://github.com/hakouguelfen/dotfiles2 dotfiles
    cd dotfiles
    stow -t ~ --ignore=README.md .
    cd

    ########################################
    ######## clone my scripts  #############
    ########################################
    git clone https://github.com/hakouguelfen/scripts .local/bin/scripts

    ########################################
    ######## clone my wallpaper  ###########
    ########################################
    sudo git clone https://github.com/hakouguelfen/wallpaper .local/share/wallpaper


    ########################################
    ######## enable device inputs ##########
    ########################################
    sudo echo '
    Section "InputClass"
           Identifier "system-keyboard"
           MatchIsKeyboard "on"
           Option "XkbLayout" "fr"
           Option "XkbModel" "pc105"
           Option "XkbOptions" "terminate:ctrl_alt_bksp"
    EndSection' > /etc/X11/xorg.conf.d/00-keyboard.conf

    sudo echo '
    Section "InputClass"
       Identifier "libinput touchpad catchall"
       Driver "libinput"
       Option "Tapping" "on"
    EndSection' > /etc/X11/xorg.conf.d/40-libinput.conf

    ########################################
    ######## Install tmux-plugins ##########
    ########################################
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    ########################################
    ######## Install doom-emacs ############
    ########################################
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install
}


fedoraInstaller(){
    if [[ -n $COMMON_PACKAGES ]]; then
        sudo dnf install $COMMON_PACKAGES
        sudo dnf install emacs-lucid

        ########################################
        ######## Enable rpmfusion ##############
        ########################################
        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        sudo dnf config-manager --enable fedora-cisco-openh264

        ########################################
        ######## Switch to full ffmpeg #########
        ########################################
        sudo dnf swap ffmpeg-free ffmpeg --allowerasing

        ########################################
        ######## Install additional codec ######
        ########################################
        sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
        sudo dnf update @sound-and-video

    else
        echo "No packages specified."
    fi
}

archInstaller(){
    if [[ -n $COMMON_PACKAGES ]]; then
        sudo pacman -S $COMMON_PACKAGES
        sudo pacman -S emacs

        ########################################
        ######## Install AUR helper ############
        ########################################
        git clone https://aur.archlinux.org/paru.git paru && cd paru || exit
        makepkg -si
        cd ..
        rm -rf paru
    else
        echo "No packages specified."
    fi
}

debianInstaller(){
    if [[ -n $COMMON_PACKAGES ]]; then
        sudo apt install $COMMON_PACKAGES
        sudo apt install emacs
    else
        echo "No packages specified."
    fi
}

main
