#!/bin/sh
# packages to install
# fonts to install
# root configs
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

pkgs=(
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
    slurp
    jq
    swaybg
    sway
    tldr
    trizen
    tmux
    udiskie
    waybar
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
)
pkgscount=0

aurpkgs=(
    neovim-nightly-bin
    spotify
    spicetify-cli
    unimatrix-git
    swappy
    bibata-cursor-theme
)
aurpkgscount=0

for name in "${pkgs[@]}"; do
    pkgscount=$[pkgscount+1]
    tput setaf 3;echo "Installing package ::  "$pkgscount" " $name;tput sgr0;
	func_install $name
done

for aurname in "${aurpkgs[@]}"; do
    aurpkgscount=$[aurpkgscount+1]
    tput setaf 3;echo "Installing package ::  "$aurpkgscount" " $aurname;tput sgr0;
	func_install_aur $aurname
done

curl -L https://get.oh-my.fish | fish
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fsSL https://starship.rs/install.sh | bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

mkdir -p ~/.local/share/fonts
cp -r .local/share/fonts ~/.local/share/fonts
