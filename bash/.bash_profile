alias la="ls -lah"
alias ll="ls -lh"
alias ls="ls --color"

alias gl="git log"
alias gs="git status"

alias m="time make -j$(grep -c ^proc /proc/cpuinfo)"
alias s='screen_switch'
alias t='todo.sh -d $HOME/Dropbox/todo/todo.cfg'

alias grep='grep --color'
alias libreoffice="GTK_THEME=Clearlooks libreoffice"

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias week='date +%V'
alias whois="whois -h whois-servers.net"

export PATH=$HOME/.local/bin:$PATH
export GDK_USE_XFT=1
export QT_XFT=true

export BROWSER="/usr/bin/google-chrome"
export EDITOR="/usr/bin/vim"
export TERMINAL="$HOME/.local/bin/smowterm"

export HISTSIZE=32768 # Larger bash history (allow 32³ entries)
export HISTFILESIZE=$HISTSIZE
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# XDG Support
if [ -e "$HOME/.config/user-dirs.dirs" ]; then
	source "$HOME/.config/user-dirs.dirs"
	[[ ! -e "$XDG_CONFIG_HOME" ]] && break

	#export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
	alias abook="abook --config $XDG_CONFIG_HOME/abook/abookrc --datafile $XDG_CONFIG_HOME/abook/addressbook"
	alias claws-mail="claws-mail --alternate-config-dir $XDG_CONFIG_HOME/claws-mail"
	alias electrum="electrum --dir $XDG_CONFIG_HOME/electrum"
	alias ledger="ledger --init-file $XDG_CONFIG_HOME/ledgerrc"
	alias pidgin="pidgin --config=$XDG_CONFIG_HOME/purple"
	export GIMP2_DIRECTORY="$XDG_DATA_HOME/gimp"
	export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
	export GRAMPSHOME="$XDG_CONFIG_HOME/gramps"
	export ICEAUTHORITY="$XDG_RUNTIME_DIR/x11/ICEauthority"
	export LESSHISTFILE="$XDG_CACHE_HOME/less"
	export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"
	export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvt-$(hostname)"
	export SCREENRC="$XDG_CONFIG_HOME/screenrc"
	export TASKRC="$XDG_CONFIG_HOME/task"
	export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"
	export WINEPREFIX="$XDG_DATA_HOME/wine"
	export XAUTHORITY="$XDG_RUNTIME_DIR/x11/Xauthority"
	export XCOMPOSEFILE="$XDG_CONFIG_HOME/x11/XCompose"
	export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
	export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
	[ -n "$DISPLAY" -a -f /usr/bin/xrdb ] && xrdb "$XDG_CONFIG_HOME/x11/Xresources"
fi

PRODUCT_ID=$(cat /sys/class/dmi/id/product_version 2> /dev/null)
if [[ "$PRODUCT_ID" =~ "ThinkPad" ]]; then
	setxkbmap -model us -layout us -variant intl -option 'terminate:ctrl_alt_bksp'

	# IBM TP mouse scrolling with middle mouse buttom
	xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
	xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2

	# IBM TP horizontal scrolling
	xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5
fi

CDARGS=/usr/share/doc/cdargs/examples/cdargs-bash.sh
grep -q Debian /etc/issue && test -f $CDARGS && . $CDARGS

[ -f ~/.bash_profile_local ] && . ~/.bash_profile_local

. shelltags -tesglfmb
