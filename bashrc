# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

export GDK_USE_XFT=1
export QT_XFT=true
export BROWSER="/usr/bin/browser"
export EDITOR="/usr/bin/vim"
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTFILESIZE=10000i
#export PS1="\n\[\033[1;36m\]\u\[\033[1;37m\] \[\033[0;36m\]`date`\n\[\033[0m\][\[\033[1;33m\]\w\[\033[0m\]] "
export PS1="\[\033[1;33m\][\$(date +%H%M)][\u@\h:\w]$\[\033[0m\] "

#export MY_PS1="[\$(date +%H%M)][\u@\h:\w]$\[\033[0m\] "
#export PROMPT_COMMAND='[ $? == 0 ] && PS1="\[\033[1;33m\]$MY_PS1" || PS1="\[\033[1;31m\]$MY_PS1"'

case "$TERM" in
    screen*) PROMPT_COMMAND='echo -ne "\033k\033\0134"'
esac

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

alias grep='grep --color'
alias diff='colordiff'
alias ls="ls --color"
alias ll="ls -lah"
alias irc_urls='tail $HOME/.weechat/urls.log'
alias doslike=$(export PS1="C:\$( pwd | sed 's:/:\\\\\\:g' )\\> ")
alias lvim="vim -c \"normal '0\""

alias bzl-grub="bzl-search --product=GRUB2 --format=\"%s | Bug %i: %S\" | column -t -s \"|\" | sort"

#set -o vi
shopt -s autocd         # move you up one directory quickly
shopt -s histappend     # don't clear the history each time

#setxkbmap -model us -layout us -variant intl -option 'terminate:ctrl_alt_bksp'
setxkbmap -model us -layout us -variant intl -option 'terminate:ctrl_alt_bksp,caps:swapescape'

# IBM TP mouse scrolling with middle mouse buttom
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
#xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 8 200

# IBM TP horizontal scrolling
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5

