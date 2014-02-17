# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias grep='grep --color'
alias diff='colordiff'
alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -lah"
alias irc_urls='tail $HOME/.weechat/urls.log'
alias lvim="vim -c \"normal '0\""
alias bzl-grub="bzl-search --product=GRUB2 --format=\"%s | Bug %i: %S\" | column -t -s \"|\" | sort"
alias t='todo.sh -d ~/.todo-txt'
alias enable_alert='PS1="$PS1\a"'

alias g='git status'
alias gs='git show'
alias ga='git add'
alias gm='git rm'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gl='git log'
alias gi='git init'
alias gp='git pull'
alias gf='git fetch'
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'

. ~/bin/__bash_prompt

#Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#set -o vi
#shopt -s autocd         # move you up one directory quickly
#shopt -s histappend     # don't clear the history each time

PRODUCT_ID=$(cat /sys/class/dmi/id/product_version 2> /dev/null)
if [ "$PRODUCT_ID" = "ThinkPad T410" ]; then
	#setxkbmap -model us -layout us -variant intl -option 'terminate:ctrl_alt_bksp'
	#setxkbmap -model us -layout us -variant intl -option 'terminate:ctrl_alt_bksp,caps:swapescape,altwin:meta_win'
	setxkbmap -model us -layout us -variant intl -option 'terminate:ctrl_alt_bksp,caps:swapescape'

	# IBM TP mouse scrolling with middle mouse buttom
	xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
	xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
	#xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 8 200

	# IBM TP horizontal scrolling
	xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5
fi
