#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
fastfetch | lolcat
eval "$(oh-my-posh init bash --config ~/oh-my-posh.json)"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export QT_QPA_PLATFORM=wayland
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi"
export FZF_COMPLETION_TRIGGER='\'
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias rm='rm -I'
alias ping='gping'
alias np='ncmpcpp'
alias ps='procs'
alias cat='bat'
alias vi='nvim'
alias ls='lsd -ail'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
