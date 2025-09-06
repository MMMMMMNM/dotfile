#!/bin/bash 
hostname=$(cat /etc/hostname)
print_err() {
  local RED='\033[0;32m]'
  local RESET='\033[0m'
  echo -e ${RED}${1}${RESET}
}
[ ! "$UID" -eq 0 ] && print_err "you mast use sudo" && exit 1
if which paru &>/dev/null; then
	paru -Syyu
else
    echo "begin install paru"
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git ~/Git/paru/
    cd ~/Git/paru
    makepkg -si
	exit 1
fi
install_name=(bat btop cava fastfetch fsh glow go-music hypr imv kitty lazygit lsd mako mpd mpv nvim wlogout rofi tmux waybar wob yazi)
for i in "${install_name[@]}"
do
    echo "$i"
	stow "$i"
done
#git
    git config --global url."https://kkgithub.com".insteadOF "https://github.com/"
#zinit install
git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fast-theme XDG:catppuccin-mocha
bat cache --build
~/dotfile/zsh/zsh.sh

