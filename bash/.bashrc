#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
source ~/dotfile/bash/.bash_first
source ~/dotfile/bash/.bash_alias
source ~/dotfile/bash/.bash_function
source ~/dotfile/bash/.bash_export
source ~/dotfile/bash/.bash_eval
PS1='[\u@\h \W]\$ '



