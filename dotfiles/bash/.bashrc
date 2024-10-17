# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias f='fc-list | fzf'
alias l='eza -lh'
alias ll='eza -lah'
alias ls='eza -lah'
alias grep='grep --color=auto'
alias tree='tree -C'
alias refresh-mirrors='sudo reflector --verbose --ipv4 --protocols https --download-timeout 5 --score 10 --sort rate --save /etc/pacman.d/mirrorlist'
alias cdhome='cd $HOME'
alias w='$HOME/Scripts/randomize-wallpaper.sh'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
