#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
fastfetch | lolcat
eval "$(zoxide init bash)"
eval "$(thefuck --alias fk)"
eval "$(fzf --bash)"
eval "$(oh-my-posh init bash --config ~/dotfile/oh-my-posh.json)"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export QT_QPA_PLATFORM=wayland
export FZF_CTRL_T_OPTS=" --preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS=" --preview 'lsd -ail --color=always'"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias tumx="zellij"
alias top="btop"
alias du="dust"
alias cd="z"
alias fzf="fzf --preview 'bat -n --color=always --line-range :500 {}'"
alias wf='wf-recorder --audio'
alias rm='rm -I'
alias ping='gping'
alias np='ncmpcpp'
alias ps='procs'
alias cat='bat'
alias vi='nvim'
alias vim="neovide"
alias ls='lsd -ail'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
