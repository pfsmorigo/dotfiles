# .bash_profile

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin
export PATH

export GDK_USE_XFT=1
export QT_XFT=true
export BROWSER="/usr/bin/google-chrome"
export EDITOR="/usr/bin/vim"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups
# Make some commands not show up in history
#export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

. smartprompt

#Save and reload the history after each command finishes
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# User specific aliases and functions

alias grep='grep --color'
alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -lah"
alias irc_urls='tail $HOME/.weechat/urls.log'
alias lvim="vim -c \"normal '0\""
alias enable_alert='PS1="$PS1\a"'
#alias task="taskassist; task"

if type -t colordiff 2>&1 > /dev/null; then
	alias diff='colordiff'
fi

alias t='todo.sh -d ~/.todo-txt'
alias s="cd ~ && screen -t"
alias g="git"
alias h="history"
alias j="jobs"

alias week='date +%V'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

#set -o vi
#shopt -s autocd         # move you up one directory quickly
#shopt -s histappend     # don't clear the history each time

PRODUCT_ID=$(cat /sys/class/dmi/id/product_version 2> /dev/null)
if [[ "$PRODUCT_ID" =~ "ThinkPad" ]]; then
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

CDARGS=/usr/share/doc/cdargs/examples/cdargs-bash.sh
grep -q Debian /etc/issue && test -f $CDARGS && . $CDARGS

[ -f ~/.bash_profile_local ] && . ~/.bash_profile_local
