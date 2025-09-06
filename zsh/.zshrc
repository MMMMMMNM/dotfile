# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/qwq/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
source ~/.zinit/bin/zinit.zsh
source ~/dotfile/zsh/.zsh_plugins
source ~/dotfile/zsh/.zsh_first
source ~/dotfile/zsh/.zsh_alias
source ~/dotfile/zsh/.zsh_function
source ~/dotfile/zsh/.zsh_export
source ~/dotfile/zsh/.zsh_eval
source ~/dotfile/zsh/.zsh_dir
# source ~/dotfile/zsh/.zsh_vimmode
source ~/dotfile/zsh/fzf.zsh
#dir
