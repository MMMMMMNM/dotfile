#!/bin/bash
#      .o.                          oooo        ooooo         o8o                                           ooooo   ooooo                                 oooo                              .o8       ooooo                          .             oooo  oooo                    .                          .   
#     .888.                         `888        `888'         `"'                                           `888'   `888'                                 `888                             "888       `888'                        .o8             `888  `888                  .o8                        .o8   
#    .8"888.     oooo d8b  .ooooo.   888 .oo.    888         oooo  ooo. .oo.   oooo  oooo  oooo    ooo       888     888  oooo    ooo oo.ooooo.  oooo d8b  888   .oooo.   ooo. .oo.    .oooo888        888  ooo. .oo.    .oooo.o .o888oo  .oooo.    888   888        .oooo.o .o888oo  .oooo.   oooo d8b .o888oo 
#   .8' `888.    `888""8P d88' `"Y8  888P"Y88b   888         `888  `888P"Y88b  `888  `888   `88b..8P'        888ooooo888   `88.  .8'   888' `88b `888""8P  888  `P  )88b  `888P"Y88b  d88' `888        888  `888P"Y88b  d88(  "8   888   `P  )88b   888   888       d88(  "8   888   `P  )88b  `888""8P   888   
#  .88ooo8888.    888     888        888   888   888          888   888   888   888   888     Y888'          888     888    `88..8'    888   888  888      888   .oP"888   888   888  888   888        888   888   888  `"Y88b.    888    .oP"888   888   888       `"Y88b.    888    .oP"888   888       888   
# .8'     `888.   888     888   .o8  888   888   888       o  888   888   888   888   888   .o8"'88b         888     888     `888'     888   888  888      888  d8(  888   888   888  888   888        888   888   888  o.  )88b   888 . d8(  888   888   888       o.  )88b   888 . d8(  888   888       888 . 
#o88o     o8888o d888b    `Y8bod8P' o888o o888o o888ooooood8 o888o o888o o888o  `V88V"V8P' o88'   888o      o888o   o888o     .8'      888bod8P' d888b    o888o `Y888""8o o888o o888o `Y8bod88P"      o888o o888o o888o 8""888P'   "888" `Y888""8o o888o o888o      8""888P'   "888" `Y888""8o d888b      "888" 
#                                                                                                                         .o..P'       888                                                                                                                                                                      
#                                                                                                                         `Y8P'       o888o                                                                                                                                                                     
sudo pacman -S pv lolcat figlet --noconfirm --needed
if which paru &>/dev/null; then
    figlet ArchLinux Install Start | pv -qL 200 | lolcat
	paru -Syyu
else
    echo "begin install paru"
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git ~/Git/paru/
    cd ~/Git/paru
    makepkg -si
	exit 1
fi
export PARU_SKIPREVIEW=1    # 自动跳过AUR审查
export PARU_NOCONFIRM=1     # 自动确认所有操作
#NOTE install App
while IFS= read -r line; do
    paru -S $line --needed
done <"InstallApp"
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

