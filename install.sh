#!/bin/bash
if which paru &>/dev/null; then
    echo "begin install"
	paru -Syyu
else
    echo "begin install paru"
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git ~/Git/paru/
    cd ~/Git/paru
    makepkg -si
	exit 1
fi
install_name=(bat btop cava fastfetch fsh glow go-music hypr imv kitty lazygit lsd mako mpd mpv nvim nwg-bar rofi tmux waybar wob yazi zsh)
for i in "${install_name[@]}"
do
    echo "$i"
	stow "$i"
done
#git
git config --global url."https://bgithub.xyz/".insteadOF "https://github.com/"
#zinit install
git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fast-theme XDG:catppuccin-mocha
bat cache --build
