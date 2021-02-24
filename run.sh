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
    trizen
    tmux
    udiskie
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
)
aurpkgscount=0

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


echo "###############################################################################"
echo "##################  FONTS "
echo "###############################################################################"
# fonts
mkdir -p ~/.local/share/fonts
cp -r .local/share/fonts/* ~/.local/share/fonts


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

tput setaf 3
echo "###############################################################################"
echo "##################  Local Config"
echo "###############################################################################"
echo
tput sgr0
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

echo "###############################################################################"
echo "##################  Root Config"
echo "###############################################################################"
#root config
cp -r $dotfiles_dir/root/* /.
echo "##################  Systemd"
sudo systemctl enable lightdm.service

# ADITIONAL configs
echo "###############################################################################"
echo "##################  omf, bass, ohmyzsh, starship, nvm"
echo "###############################################################################"
# omf, bass, starship, nvm
fish -c "curl -L https://get.oh-my.fish | fish"
fish -c "omf install bass"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "curl -fsSL https://starship.rs/install.sh | bash"
sh -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash"

#NOTES
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