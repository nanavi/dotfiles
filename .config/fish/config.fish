# ~/.config/fish/config.fish

alias update "sudo pacman -Syyu"
alias jctl "journalctl -p 3 -xb"
alias chrome "google-chrome-stable --force-dark-mode"
alias sr "sudo reboot"
alias tobash "sudo chsh $USER -s (which bash) && echo 'Now log out.'"
alias tozsh "sudo chsh $USER -s (which zsh) && echo 'Now log out.'"
alias tofish "sudo chsh $USER -s (which fish) && echo 'Now log out.'"
alias cleanup "sudo pacman -Qtdq | sudo pacman -Rns -"
alias ll "exa -ll"
alias la "exa -la"

abbr google-chrome-stable "google-chrome-stable --force-dark-mode"
abbr chrome "google-chrome-stable --force-dark-mode"
abbr install-fonts "sudo fc-cache -fv"
abbr pacman "sudo pacman"
abbr bemenu-run "LD_LIBRARY_PATH=~/.config/bemenu BEMENU_RENDERERS=~/.config/bemenu bemenu-run"
abbr mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

starship init fish | source
