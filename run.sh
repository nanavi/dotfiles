#!/usr/bin/env sh
# packages to install
# fonts to install
# configs
# root configs
# systemd
# aditional 
func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}
func_install_aur() {
	if yay -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The AUR package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing AUR package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	yay -S $1
    fi
}

mypkgs=(
    linux
    linux-lts
    linux-zen
    linux-headers
    linux-lts-headers
    linux-zen-headers
    alacritty
    bat
    kitty
    waybar
    rofi
    ranger
    grim
    mako
    fish
    noto-fonts-emoji
    mpv
    pamixer
    pavucontrol
    pfetch
    pango
    exa
    feh
    slurp
    playerctl
    steam
    swayidle
    swaylock
    jq
    swaybg
    sway
    tldr
    tmux
    wayland-protocols
    wl-clipboard
    wlroots
    xorg-xwayland
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    ripgrep
    youtube-dl
    deno
    discord
    emacs
    fd
    vulkan-icd-loader
    lib32-vulkan-icd-loader
    vulkan-radeon
    vulkan-tools
    lib32-vulkan-radeon
    procs
    imv
    nnn
    obs-studio
    libva-mesa-driver
    papirus-icon-theme
    ttf-liberation
    steam
    xorg
    wget
    curl
    opendoas
    qtile
    brave
    firefox
    lxappearance
    reflector
)
pkgscount=0

myaurpkgs=(
    neovim-nightly-bin
    vscodium-bin
    spotify
    spicetify-cli
    unimatrix-git
    swappy
    bibata-cursor-theme
    opencl-amd
    lightdm-webkit2-theme-glorious
    google-chrome
    openrazer-meta-git
    polychromatic-git
)
aurpkgscount=0

basic_pkgs=(
    linux
    linux-lts
    linux-headers
    linux-lts-headers
    xorg
    wget
    curl
    wayland-protocols
    wl-clipboard
    wlroots
    xorg-wayland
    waybar
    slurp
    sway
    swayidle
    swaylock
    swaybg
    grim
    jq
    playerctl
    pamixer
    pavucontrol
    neofetch
    noto-fonts-emoji
    pfetch
    rofi
    ranger
    mako
    dunst
    qtile
    feh
    papirus-icon-theme
    alacritty
    pango
    ripgrep
    exa
    procs
    bat
    fd
    zsh
    emacs
    imv
    youtube-dl
    opendoas
    firefox
    brave
    lxappearance
    reflector
)
basic_aurpkgs=(
    lightdm-webkit2-theme-glorious
    bibata-cursor-theme
    neovim-nightly-bin
    swappy
    unimatrix-git
)

install_my_pkgs() {
    for name in "${mypkgs[@]}"; do
        pkgscount=$[pkgscount+1]
        tput setaf 3;echo "Installing package ::  "$pkgscount" " $name;tput sgr0;
    	func_install $name
    done
    
    for aurname in "${myaurpkgs[@]}"; do
        aurpkgscount=$[aurpkgscount+1]
        tput setaf 3;echo "Installing package ::  "$aurpkgscount" " $aurname;tput sgr0;
    	func_install_aur $aurname
    done
}

dotfiles_dir="$( cd "$(dirname "$0")" ; pwd -P )"


install_fonts() {
    echo "###############################################################################"
    echo "##################  FONTS "
    echo "###############################################################################"
    # fonts
    mkdir -p ~/.local/share/fonts
    cp -r .local/share/fonts/* ~/.local/share/fonts
    fc-cache -fv
}


bootstrap_list=(
    .config/alacritty
    .config/dwm
    .config/fish
    .config/fontconfig
    .config/gtk-3.0
    .config/kitty
    .config/mako
    .config/neofetch
    .config/ranger
    .config/rofi
    .config/st
    .config/sway
    .config/waybar
    .dwm
    .local
    .scripts
    .wallpapers
    .bash_profile
    .bashrc
    .bashrc-personal
    .face
    .xinitrc
    .zshrc
    .zshrc-personal
    .gtkrc-2.0
)

red='\033[0;31m'
cyan='\033[0;36m'
nocol='\033[0m'

symlink_dot_config() {
    echo "###############################################################################"
    echo "##################  Local Config"
    echo "###############################################################################"
    # symbolic links, 
    rm -rf $HOME/.config/neofetch
    
    if [[ $1 == "clean" ]]
    then
        for i in "${bootstrap_list[@]}"
        do
            rm -r ~/$i
            [[ $? -eq 0 ]] && echo -e removed ~/$red$i$nocol
        done
    else
        for i in "${bootstrap_list[@]}"
        do
            ln -sT $dotfiles_dir/$i ~/$i
            [[ $? -eq 0 ]] && echo -e $dotfiles_dir/$cyan$i$nocol "->" ~/$cyan$i$nocol
        done
    fi
}

copy_root_config() {
    echo "###############################################################################"
    echo "##################  Root Config"
    echo "###############################################################################"
    #root config
    cp -r $dotfiles_dir/root/* /.
}

enable_systemd_services() {
    echo "###############################################################################"
    echo "##################  Systemd "
    sudo systemctl enable lightdm.service
}

# ADITIONAL configs
install_additional() {
    echo "###############################################################################"
    echo "##################  omf, bass, ohmyzsh, starship, nvm"
    echo "###############################################################################"
    # omf, bass, starship, nvm
    fish -c "curl -L https://get.oh-my.fish | fish"
    fish -c "omf install bass"
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sh -c "curl -fsSL https://starship.rs/install.sh | bash"
    sh -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash"
}

#NOTES
notes() {
    echo "###############################################################################"
    echo "SEE $HOME/TODO"
    echo "###############################################################################"
    echo "
    1. On /usr/share/vscodium-bin/resources/app/product.json
       REPLACE 'extensionsGallery' WITH $HOME/TODO
      \"extensionsGallery\": {
        \"itemUrl\": \"https://marketplace.visualstudio.com/items\",
        \"serviceUrl\": \"https://marketplace.visualstudio.com/_apis/public/gallery\"
      },
    2. spicetfy-cli https://github.com/khanhas/spicetify-cli/wiki/Installation
    3. https://wiki.archlinux.org/index.php/LightDM#Changing_your_avatar
    " > $HOME/TODO
}


if [ $1 == "personal" ]
then
    install_my_pkgs
    install_fonts
    symlink_dot_config
    copy_root_config
    enable_systemd_services
    install_additional
    notes
elif [$1 == "basic"]
then
    echo "BASIC"
else
    echo "DOING NOTHING"
fi